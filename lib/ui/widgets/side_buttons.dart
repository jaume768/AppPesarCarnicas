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
              SizedBox(width: 10), // Separación entre los botones
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
                        // Aquí puedes colocar cualquier lógica adicional necesaria para manejar el evento de este botón.
                      } : null,
                    );
                  },
                ),
              ),
              SizedBox(width: 10), // Separación entre los botones
            ],
          ),
          SizedBox(height: 50),
          Center(
            child: _buildButton(context, 'ENVIAR FINAL', Colors.grey.shade300, () {}),
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
          onPressed: onPressed,  // Ahora puede ser null o una función
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
