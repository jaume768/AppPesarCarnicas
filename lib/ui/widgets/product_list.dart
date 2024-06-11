import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../data/repositories/pesaje_repository.dart';
import '../../structure/bloc/pesaje/pesaje_event.dart';
import '../../structure/bloc/products/products_bloc.dart';
import '../../structure/bloc/products/products_event.dart';
import '../../structure/bloc/products/products_state.dart';
import '../../structure/bloc/pesaje/pesaje_bloc.dart';
import '../../structure/bloc/pesaje/pesaje_state.dart';
import '../../models/client.dart';
import '../utils/confirm_delete_modal.dart';

class ProductListTable extends StatelessWidget {
  final List<Client> products;
  final String? selectedClient;
  final PesajeRepository pesajeRepository;

  const ProductListTable({Key? key, required this.products, this.selectedClient, required this.pesajeRepository}) : super(key: key);

  Future<void> _showConfirmDeleteModal(BuildContext context, String clientName, String articleName, String articleObservation, int articleId) async {
    try {
      final weightData = await pesajeRepository.getArticleWeight(articleId);
      final weight = weightData['pes'];

      showDialog(
        context: context,
        builder: (BuildContext context) {
          final productState = BlocProvider.of<ProductBloc>(context).state;
          return ConfirmDeleteModal(
            clientName: clientName,
            productName: articleName,
            productObservation: articleObservation,
            weight: weight,
            onConfirm: () {
              for (var product in products) {
                for (var articulo in product.articles) {
                  if (articulo.isAccepted && productState.selectedArticle == articulo.code) {
                    articulo.isAccepted = false;
                    BlocProvider.of<ProductBloc>(context).add(AcceptArticle(productState.selectedArticle, false));
                    Navigator.of(context).pop();
                    return;
                  }
                }
              }
              BlocProvider.of<ProductBloc>(context).add(AcceptArticle(articleId, true));
              Navigator.of(context).pop();
            },
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.errorFetchingWeight(e.toString()))),
      );
    }
  }

  Future<void> _showPendingModal(BuildContext context, int articleId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.markedAsPending),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  final productState = BlocProvider.of<ProductBloc>(context).state;
                  for (var product in products) {
                    for (var articulo in product.articles) {
                      if (articulo.isMarket && productState.selectedArticle == articulo.code) {
                        articulo.isMarket = false;
                        BlocProvider.of<ProductBloc>(context).add(MarkAsPending(productState.selectedArticle, false));
                        Navigator.of(context).pop();
                        return;
                      }
                    }
                  }
                  BlocProvider.of<ProductBloc>(context).add(MarkAsPending(articleId, false));
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(
                  AppLocalizations.of(context)!.removePending,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.close,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, productState) {
        return BlocBuilder<PesajeBloc, PesajeState>(
          builder: (context, pesajeState) {
            if (productState is ProductLoaded) {
              List<DataRow> rows = [];
              int rowIndex = 0;

              for (var product in products) {
                if (selectedClient != null && product.name != selectedClient) continue;

                rows.add(
                  DataRow(
                    color: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        return Colors.green[300];
                      },
                    ),
                    cells: [
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(
                        Center(
                          child: Text(
                            '${product.name} (${product.code})',
                            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                );

                for (var article in product.articles) {
                  int articleId = article.id;

                  rows.add(
                    DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (productState.selectedArticle == articleId && article.isMarket) {
                            return Colors.red[400];
                          }
                          if (productState.selectedArticle == articleId && productState.pendingArticles.contains(articleId)) {
                            return Colors.red[400];
                          }
                          if (productState.pendingArticles.contains(articleId) || article.isMarket) {
                            return Colors.red[200];
                          }

                          if (productState.acceptedArticles.contains(articleId) || article.isAccepted) {
                            return Colors.blue[400];
                          }
                          if (productState.selectedArticle == articleId) {
                            return Colors.grey[300];
                          }
                          return null;
                        },
                      ),
                      cells: [
                        DataCell(
                          InkWell(
                            onTap: () {
                              if (productState.pendingArticles.contains(articleId) || article.isMarket) {
                                BlocProvider.of<ProductBloc>(context).add(SelectArticle(articleId, article.special, article.mandatoryLot, product.code));
                                _showPendingModal(context, articleId);
                              } else if (productState.acceptedArticles.contains(articleId) || article.isAccepted) {
                                BlocProvider.of<ProductBloc>(context).add(SelectArticle(articleId, article.special, article.mandatoryLot, product.code));
                                _showConfirmDeleteModal(context, product.name, article.name, article.observation, articleId);
                              } else {
                                if (productState.selectedArticle == articleId) {
                                  BlocProvider.of<ProductBloc>(context).add(DeselectArticle(articleId));
                                  BlocProvider.of<PesajeBloc>(context).add(StopPesajeMonitoring());
                                } else {
                                  BlocProvider.of<ProductBloc>(context).add(SelectArticle(articleId, article.special, article.mandatoryLot, product.code));
                                  BlocProvider.of<PesajeBloc>(context).add(StartPesajeMonitoring());
                                }
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 20),
                              width: double.infinity,
                              child: Text(
                                article.special ? 'X' : '',
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          InkWell(
                            onTap: () {
                              if (productState.pendingArticles.contains(articleId) || article.isMarket) {
                                BlocProvider.of<ProductBloc>(context).add(SelectArticle(articleId, article.special, article.mandatoryLot, product.code));
                                _showPendingModal(context, articleId);
                              } else if (productState.acceptedArticles.contains(articleId) || article.isAccepted) {
                                BlocProvider.of<ProductBloc>(context).add(SelectArticle(articleId, article.special, article.mandatoryLot, product.code));
                                _showConfirmDeleteModal(context, product.name, article.name, article.observation, articleId);
                              } else {
                                if (productState.selectedArticle == articleId) {
                                  BlocProvider.of<ProductBloc>(context).add(DeselectArticle(articleId));
                                  BlocProvider.of<PesajeBloc>(context).add(StopPesajeMonitoring());
                                } else {
                                  BlocProvider.of<ProductBloc>(context).add(SelectArticle(articleId, article.special, article.mandatoryLot, product.code));
                                  BlocProvider.of<PesajeBloc>(context).add(StartPesajeMonitoring());
                                }
                              }
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    article.units.toString(),
                                    style: TextStyle(color: Colors.black, fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          InkWell(
                            onTap: () {
                              if (productState.pendingArticles.contains(articleId) || article.isMarket) {
                                BlocProvider.of<ProductBloc>(context).add(SelectArticle(articleId, article.special, article.mandatoryLot, product.code));
                                _showPendingModal(context, articleId);
                              } else if (productState.acceptedArticles.contains(articleId) || article.isAccepted) {
                                BlocProvider.of<ProductBloc>(context).add(SelectArticle(articleId, article.special, article.mandatoryLot, product.code));
                                _showConfirmDeleteModal(context, product.name, article.name, article.observation, articleId);
                              } else {
                                if (productState.selectedArticle == articleId) {
                                  BlocProvider.of<ProductBloc>(context).add(DeselectArticle(articleId));
                                  BlocProvider.of<PesajeBloc>(context).add(StopPesajeMonitoring());
                                } else {
                                  BlocProvider.of<ProductBloc>(context).add(SelectArticle(articleId, article.special, article.mandatoryLot, product.code));
                                  BlocProvider.of<PesajeBloc>(context).add(StartPesajeMonitoring());
                                }
                              }
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    article.unitType.toString(),
                                    style: TextStyle(color: Colors.black, fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          InkWell(
                            onTap: () {
                              if (productState.pendingArticles.contains(articleId) || article.isMarket) {
                                BlocProvider.of<ProductBloc>(context).add(SelectArticle(articleId, article.special, article.mandatoryLot, product.code));
                                _showPendingModal(context, articleId);
                              } else if (productState.acceptedArticles.contains(articleId) || article.isAccepted) {
                                BlocProvider.of<ProductBloc>(context).add(SelectArticle(articleId, article.special, article.mandatoryLot, product.code));
                                _showConfirmDeleteModal(context, product.name, article.name, article.observation, articleId);
                              } else {
                                if (productState.selectedArticle == articleId) {
                                  BlocProvider.of<ProductBloc>(context).add(DeselectArticle(articleId));
                                  BlocProvider.of<PesajeBloc>(context).add(StopPesajeMonitoring());
                                } else {
                                  BlocProvider.of<ProductBloc>(context).add(SelectArticle(articleId, article.special, article.mandatoryLot, product.code));
                                  BlocProvider.of<PesajeBloc>(context).add(StartPesajeMonitoring());
                                }
                              }
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    article.name,
                                    style: TextStyle(color: Colors.black, fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    article.observation,
                                    style: TextStyle(color: Colors.black, fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            DataTable(
                              columnSpacing: 47.0,
                              dataRowHeight: 80.0,
                              headingRowHeight: 70.0,
                              border: const TableBorder(
                                horizontalInside: BorderSide(color: Colors.black, width: 2),
                                verticalInside: BorderSide(color: Colors.black, width: 2),
                                right: BorderSide(color: Colors.black, width: 2),
                                bottom: BorderSide(color: Colors.black, width: 2),
                                top: BorderSide(color: Colors.black, width: 2),
                                left: BorderSide(color: Colors.black, width: 2),
                              ),
                              columns: [
                                DataColumn(label: Text(AppLocalizations.of(context)!.block, style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.center)),
                                DataColumn(label: Text(AppLocalizations.of(context)!.quantity, style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.center)),
                                DataColumn(label: Text(AppLocalizations.of(context)!.unit, style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.center)),
                                DataColumn(label: Text(AppLocalizations.of(context)!.clientProduct, style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.center)),
                              ],
                              rows: rows,
                            ),
                            Expanded(child: Container()), // This ensures the DataTable stays at the top
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text(AppLocalizations.of(context)!.productsNotLoaded));
            }
          },
        );
      },
    );
  }
}
