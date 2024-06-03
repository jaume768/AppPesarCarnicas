import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  const ProductListTable({Key? key, required this.products, this.selectedClient}) : super(key: key);

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
                          if (productState.selectedArticle == articleId && productState.pendingArticles.contains(articleId)) {
                            return Colors.red[400];
                          }
                          if (productState.pendingArticles.contains(articleId)) {
                            return Colors.red[200];
                          }
                          if (productState.acceptedArticles.contains(articleId)) {
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
                          Center(
                            child: Text(
                              article.special ? 'X' : '',
                              style: TextStyle(color: Colors.black, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataCell(
                          GestureDetector(
                            onTap: () {
                              if (productState.acceptedArticles.contains(articleId)) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ConfirmDeleteModal(
                                      clientName: product.name,
                                      productName: article.name,
                                      productObservation: article.observation,
                                      weight: article.weight,
                                      onConfirm: () {
                                        BlocProvider.of<ProductBloc>(context).add(AcceptArticle(articleId));
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                );
                              } else {
                                if (productState.selectedArticle == articleId) {
                                  BlocProvider.of<ProductBloc>(context).add(DeselectArticle(articleId));
                                  BlocProvider.of<PesajeBloc>(context).add(StopPesajeMonitoring());
                                } else {
                                  BlocProvider.of<ProductBloc>(context).add(SelectArticle(articleId, article.special, article.mandatoryLot));
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
                          GestureDetector(
                            onTap: () {
                              if (productState.acceptedArticles.contains(articleId)) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ConfirmDeleteModal(
                                      clientName: product.name,
                                      productName: article.name,
                                      productObservation: article.observation,
                                      weight: article.weight,
                                      onConfirm: () {
                                        BlocProvider.of<ProductBloc>(context).add(AcceptArticle(articleId));
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                );
                              } else {
                                if (productState.selectedArticle == articleId) {
                                  BlocProvider.of<ProductBloc>(context).add(DeselectArticle(articleId));
                                  BlocProvider.of<PesajeBloc>(context).add(StopPesajeMonitoring());
                                } else {
                                  BlocProvider.of<ProductBloc>(context).add(SelectArticle(articleId, article.special, article.mandatoryLot));
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
                          GestureDetector(
                            onTap: () {
                              if (productState.acceptedArticles.contains(articleId)) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ConfirmDeleteModal(
                                      clientName: product.name,
                                      productName: article.name,
                                      productObservation: article.observation,
                                      weight: article.weight,
                                      onConfirm: () {
                                        BlocProvider.of<ProductBloc>(context).add(AcceptArticle(articleId));
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                );
                              } else {
                                if (productState.selectedArticle == articleId) {
                                  BlocProvider.of<ProductBloc>(context).add(DeselectArticle(articleId));
                                  BlocProvider.of<PesajeBloc>(context).add(StopPesajeMonitoring());
                                } else {
                                  BlocProvider.of<ProductBloc>(context).add(SelectArticle(articleId, article.special, article.mandatoryLot));
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

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: DataTable(
                        columnSpacing: 7.0,
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
                        columns: const [
                          DataColumn(label: Text('BLOC', style: TextStyle(color: Colors.black, fontSize: 20,), textAlign: TextAlign.center)),
                          DataColumn(label: Text('QUANT.', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.center)),
                          DataColumn(label: Text('UNI', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.center)),
                          DataColumn(label: Text('CLIENT/ PRODUCTE', style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.center)),
                        ],
                        rows: rows,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: Text('No se han cargado los productos'));
            }
          },
        );
      },
    );
  }
}
