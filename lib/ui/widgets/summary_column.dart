import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_event.dart';
import '../../structure/bloc/carniceria/carniceria_state.dart';

class SummaryColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          const Text(
            'RESUM',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Expanded(
            child: BlocBuilder<CarniceriaBloc, CarniceriaState>(
              builder: (context, state) {
                if (state.selectedProductType == null) {
                  return Center(child: Text("Seleccione una categoría"));
                }

                final options = state.optionsMap[state.selectedProductType!] ?? [];
                return ListView.builder(
                  itemCount: state.summaries.length,
                  itemBuilder: (context, index) {
                    if (options.isNotEmpty && index < options.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Nº ${state.summaries[index]}  ', style: TextStyle(fontSize: 16)),
                            Switch(
                              value: options[index],
                              onChanged: (value) {
                                context.read<CarniceriaBloc>().add(ToggleOption(index));
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(child: Text("No hay opciones disponibles."));
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
