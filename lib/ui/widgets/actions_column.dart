import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../structure/bloc/configuration/configuration_bloc.dart';
import '../../structure/bloc/configuration/configuration_event.dart';
import '../../structure/bloc/configuration/configuration_state.dart';

class ActionsColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton(context, 'Seleccionar Báscula', Colors.lightBlue, true),
          _buildButton(context, 'Seleccionar Impresora', Colors.pink, false),
          _buildButton(context, 'Veure Totals x Article', Colors.red, null),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color color, bool? isScale) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: color,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        onPressed: isScale == null ? null : () {
          _showSelectionDialog(context, isScale);
        },
        child: Text(text),
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
