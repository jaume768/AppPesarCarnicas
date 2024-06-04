import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../structure/bloc/products/products_bloc.dart';
import '../../structure/bloc/products/products_event.dart';
import '../../structure/bloc/products/products_state.dart';
import '../../structure/bloc/pesaje/pesaje_bloc.dart';
import '../../structure/bloc/pesaje/pesaje_event.dart';
import '../../structure/bloc/pesaje/pesaje_state.dart';
import '../utils/lot_number_modal.dart';
import 'multi_per_indicators.dart';

class SideButtons extends StatelessWidget {
  final VoidCallback onFilterClient;
  final VoidCallback onClearFilter;

  const SideButtons({required this.onFilterClient, required this.onClearFilter});

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
          child: _buildButton(context, 'REVISAR COMPLET', Colors.lightBlue, () {}),
        ),
        Expanded(
          child: _buildButton(context, 'CANVIAR CONFIGURACIÓ', Colors.yellow.shade300, () {
            Navigator.pop(context);
          }),
        ),
      ],
    );
  }

  Widget _buildMiddleButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _buildButton(context, 'FILTRAR CLIENT', Colors.green.shade300, onFilterClient),
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
        BlocProvider.of<ProductBloc>(context).add(MarkAsPending(currentState.selectedArticle));
      }
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
              BlocProvider.of<ProductBloc>(context).add(AcceptArticle(productState.selectedArticle));
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
        MultiPesIndicators(), // Mantén siempre visibles los indicadores Multi Pes
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
                  child: Text(
                    state.lotNumber == 0 ? 'S/N' : state.lotNumber.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    minimumSize: Size(100, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    side: BorderSide(color: Colors.black, width: 1),
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
          builder: (context, state) {
            bool isAcceptButtonEnabled = !(state is PesajeLoaded && (state.pesajeStatus['tipoPes'] == 'ZERO' || state.pesajeStatus['tipoPes'] == 'INESTABLE'));
            return _buildCustomButton(
              'Aceptar Pesada,\ngravar, imprimir',
              isAcceptButtonEnabled ? Colors.blueAccent : Colors.grey,
              200,
              100,
              isAcceptButtonEnabled ? () {
                final productState = BlocProvider.of<ProductBloc>(context).state;
                print(productState.selectedArticle);
                if (productState is ProductLoaded) {
                  BlocProvider.of<ProductBloc>(context).add(AcceptArticle(productState.selectedArticle));
                }
              } : null,
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
        child: Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 24),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: Size(width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          side: BorderSide(color: Colors.black, width: 1),
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
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 17),
            textAlign: TextAlign.center,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            side: BorderSide(color: Colors.black, width: 1),
          ),
        ),
      ),
    );
  }
}
