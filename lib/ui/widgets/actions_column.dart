import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../structure/bloc/configuration/configuration_bloc.dart';
import '../../structure/bloc/configuration/configuration_event.dart';
import '../../structure/bloc/configuration/configuration_state.dart';

class ActionsColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ConfigurationBloc, ConfigurationState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              _buildButton(
                context,
                'Seleccionar Báscula',
                state.selectedScale != null ? 'Seleccionado: ${state.selectedScale['name']}' : 'Seleccionar Báscula',
                Colors.lightBlue,
                true,
              ),
              SizedBox(height: 10),
              _buildButton(
                context,
                'Seleccionar Impresora',
                state.selectedPrinter != null ? 'Seleccionado: ${state.selectedPrinter['name']}' : 'Seleccionar Impresora',
                Colors.pink,
                false,
              ),
              SizedBox(height: 10),
              _buildButton(context, 'Veure Totals x Article', 'Veure Totals x Article', Colors.red, null),
            ],
          );
        },
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, String displayText, Color color, bool? isScale) {
    return Container(
      width: 190,
      height: 190, // Altura fija para los botones
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: color,
          minimumSize: Size(0, 0), // Tamaño mínimo 0 para asegurar el cuadrado
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        onPressed: isScale == null
            ? (){}
            : () {
          _showSelectionDialog(context, isScale);
        },
        child: Center(
          child: Text(
            displayText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22), // Ajusta el tamaño del texto según sea necesario
          ),
        ),
      ),
    );
  }

  void _showSelectionDialog(BuildContext context, bool isScale) {
    context.read<ConfigurationBloc>().add(FetchConfiguration());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<ConfigurationBloc, ConfigurationState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            final items = isScale ? state.scales : state.printers;
            return AlertDialog(
              title: Text(isScale ? 'Seleccionar Báscula' : 'Seleccionar Impresora'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: items.map((item) {
                    return ListTile(
                      title: Text(item['name']),
                      onTap: () {
                        if (isScale) {
                          context.read<ConfigurationBloc>().add(SelectScale(item));
                        } else {
                          context.read<ConfigurationBloc>().add(SelectPrinter(item));
                        }
                        Navigator.of(context).pop();
                      },
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
