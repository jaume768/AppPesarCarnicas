import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../structure/bloc/carniceria/carniceria_bloc.dart';
import '../../../structure/bloc/carniceria/carniceria_event.dart';
import '../../../structure/bloc/carniceria/carniceria_state.dart';

class SummaryColumn extends StatelessWidget {
  const SummaryColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          Text(
            AppLocalizations.of(context)!.summary,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          Expanded(
            child: BlocBuilder<CarniceriaBloc, CarniceriaState>(
              builder: (context, state) {
                if (state.selectedProductType == null) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)!.selectCategory,
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                }

                final options = state.optionsMap[state.selectedProductType!] ?? [];
                return ListView.builder(
                  itemCount: state.summaries.length,
                  itemBuilder: (context, index) {
                    if (options.isNotEmpty && index < options.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Nº ${state.summaries[index]}       ', style: const TextStyle(fontSize: 26)), // Aumenta el tamaño del texto
                            Transform.scale(
                              scale: 1.5,
                              child: Switch(
                                value: options[index],
                                onChanged: (value) {
                                  context.read<CarniceriaBloc>().add(ToggleOption(index));
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)!.noOptionsAvailable,
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
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
