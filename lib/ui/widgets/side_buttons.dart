import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../structure/bloc/products/products_bloc.dart';
import '../../structure/bloc/products/products_event.dart';
import '../../structure/bloc/products/products_state.dart';

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
          Row(
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
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildButton(context, 'FILTRAR CLIENT', Colors.green.shade300, onFilterClient),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _buildButton(context, 'MARCAR PENDENT', Colors.grey.shade300, () {
                  final currentState = BlocProvider.of<ProductBloc>(context).state;
                  if (currentState is ProductLoaded) {
                    BlocProvider.of<ProductBloc>(context).add(MarkAsPending(currentState.selectedArticle));
                  }
                }),
              ),
              Expanded(
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    final isEnabled = state is ProductLoaded && state.selectedArticle != -1;
                    final buttonText = (state is ProductLoaded && state.isSpecial) ? 'ETIQUETA BLOC' : 'PES PRODUCTE';
                    return _buildButton(
                      context,
                      buttonText,
                      isEnabled ? Colors.orange : Colors.grey.shade300,
                      isEnabled ? () {
                        print('Procesar artículo seleccionado: ${state.selectedArticle}');
                      } : null,
                    );
                  },
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 50),
          Center(
            child: _buildButton(context, 'ENVIAR FINAL', Colors.grey.shade300, () {}),
          ),
          Spacer(),
          Column(
            children: [
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoaded && state.isMandatoryLot) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: _buildButton(
                        context,
                        'LOTE',
                        Colors.red,
                            () {
                          // Acción para el botón Lote
                        },
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: Container(
                  color: Colors.green.shade200,
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '0,00',
                    style: TextStyle(color: Colors.black, fontSize: 48),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 50),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Multi Pes', style: TextStyle(color: Colors.black, fontSize: 24)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        minimumSize: Size(100, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        side: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 50),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Aceptar Pesada,', style: TextStyle(color: Colors.black, fontSize: 24)),
                          Text('gravar, imprimir', style: TextStyle(color: Colors.black, fontSize: 24)),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        minimumSize: Size(200, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        side: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
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
