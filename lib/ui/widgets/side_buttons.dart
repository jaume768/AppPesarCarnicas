import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/pesaje_repository.dart';
import '../../structure/bloc/products/products_bloc.dart';
import '../../structure/bloc/products/products_event.dart';
import '../../structure/bloc/products/products_state.dart';
import '../../structure/bloc/pesaje/pesaje_bloc.dart';
import '../../structure/bloc/pesaje/pesaje_event.dart';
import '../../structure/bloc/pesaje/pesaje_state.dart';
import '../utils/lot_number_modal.dart';
import 'multi_per_indicators.dart';
import '../../models/client.dart';

class SideButtons extends StatelessWidget {
  final List<Client> products;
  final VoidCallback onFilterClient;
  final VoidCallback onClearFilter;
  final PesajeRepository pesajeRepository;
  final bool isFilterActive;

  const SideButtons({
    required this.products,
    required this.onFilterClient,
    required this.onClearFilter,
    required this.pesajeRepository,
    required this.isFilterActive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopButtons(context),
          const SizedBox(height: 50),
          _buildMiddleButtons(context),
          const SizedBox(height: 50),
          const Spacer(),
          _buildBottomSection(context),
        ],
      ),
    );
  }

  Widget _buildTopButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildButton(context, 'REVISAR COMPLET', Colors.lightBlue, () {
            _showFunctionalityAlert(context);
          }),
        ),
        Expanded(
          child: _buildButton(context, 'CANVIAR CONFIGURACIÓ', Colors.yellow.shade300, () {
            Navigator.pop(context);
          }),
        ),
      ],
    );
  }

  void _showFunctionalityAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alerta"),
          content: Text("Falta funcionalidad, avisa a informática"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildMiddleButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _buildButton(context, isFilterActive ? 'QUITAR FILTRO' : 'FILTRAR CLIENT', Colors.green.shade300, isFilterActive ? onClearFilter : onFilterClient),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildMarkAsPendingButton(context),
        ),
        Expanded(
          child: _buildBlocButton(context),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildMarkAsPendingButton(BuildContext context) {
    return _buildButton(context, 'MARCAR PENDENT', Colors.grey.shade300, () {
      final currentState = BlocProvider.of<ProductBloc>(context).state;
      if (currentState is ProductLoaded) {
        for (var product in products) {
          for (var articulo in product.articles) {
            if (articulo.isMarket && currentState.selectedArticle == articulo.code) {
              articulo.isMarket = false;
              BlocProvider.of<ProductBloc>(context).add(MarkAsPending(currentState.selectedArticle, false));
              return;
            }
          }
        }
      }
      BlocProvider.of<ProductBloc>(context).add(MarkAsPending(currentState.selectedArticle, true));
    });
  }

  Widget _buildBlocButton(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        final buttonText = (state is ProductLoaded && state.isSpecial) ? 'ETIQUETA BLOC' : 'PES PRODUCTE';
        return _buildButton(
          context,
          buttonText,
          Colors.orange,
              () {
            final productState = BlocProvider.of<ProductBloc>(context).state;
            if (productState is ProductLoaded) {
              BlocProvider.of<ProductBloc>(context).add(AcceptArticle(productState.selectedArticle, true));
            }
          },
        );
      },
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Column(
      children: [
        _buildMandatoryLotSection(context),
        MultiPesIndicators(),
        _buildBottomButtons(context),
      ],
    );
  }

  Widget _buildMandatoryLotSection(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded && state.isMandatoryLot) {
          return Container(
            margin: EdgeInsets.only(bottom: 20, left: 165),
            child: Row(
              children: [
                Text('LOT:', style: TextStyle(color: Colors.black, fontSize: 24)),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _showLotNumberModal(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    minimumSize: Size(100, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                  child: Text(
                    state.lotNumber == 0 ? 'S/N' : state.lotNumber.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                ),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  void _showLotNumberModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: BlocProvider.of<ProductBloc>(context),
          child: LotNumberModal(),
        );
      },
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildCustomButton('Multi Pes', Colors.pink, 100, 100, () {
          BlocProvider.of<PesajeBloc>(context).add(AccumulateWeight());
          BlocProvider.of<PesajeBloc>(context).add(IncrementCount());
        }),
        BlocBuilder<PesajeBloc, PesajeState>(
          builder: (context, pesajeState) {
            return BlocBuilder<ProductBloc, ProductState>(
              builder: (context, productState) {
                bool isWeightStable = pesajeState is PesajeLoaded &&
                    pesajeState.pesajeStatus['tipoPes'] != 'ZERO' &&
                    pesajeState.pesajeStatus['tipoPes'] != 'INESTABLE';

                bool isLotValid = productState is ProductLoaded &&
                    ((productState.isMandatoryLot && productState.lotNumber > 0) ||
                        !productState.isMandatoryLot);

                bool isPendingOrMarked = productState is ProductLoaded &&
                    (productState.pendingArticles.contains(productState.selectedArticle) ||
                        productState.acceptedArticles.contains(productState.selectedArticle) ||
                        products.any((product) =>
                            product.articles.any((article) =>
                            article.id == productState.selectedArticle && (article.isMarket || article.isAccepted))));

                bool isAcceptButtonEnabled = isWeightStable && isLotValid && !isPendingOrMarked;

                return _buildCustomButton(
                  'Aceptar Pesada,\ngravar, imprimir',
                  isAcceptButtonEnabled ? Colors.blueAccent : Colors.grey,
                  200,
                  100,
                  isAcceptButtonEnabled ? () async {
                    try {
                      await pesajeRepository.sendArticleWeight(
                          articleId: productState.selectedArticle,
                          weight: pesajeState.weight ?? 0.0,
                          accumulatedWeight: pesajeState.accumulatedWeight,
                          clientCode: productState.clientCode
                      );
                      BlocProvider.of<ProductBloc>(context).add(AcceptArticle(productState.selectedArticle, true));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al enviar el peso: ${e.toString()}')),
                      );
                    }
                  } : null,
                );
              },
            );
          },
        ),
      ],
    );
  }



  Widget _buildCustomButton(String text, Color color, double width, double height, VoidCallback? onPressed) {
    return Container(
      margin: EdgeInsets.only(right: 50),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: Size(width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          side: BorderSide(color: Colors.black, width: 1),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color color, VoidCallback? onPressed) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      child: SizedBox(
        width: 175,
        height: 60,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            side: BorderSide(color: Colors.black, width: 1),
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 17),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
