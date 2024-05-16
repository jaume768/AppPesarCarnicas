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
          SizedBox(height: 20),
          Text(
            'RESUM',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Expanded(
            child: BlocBuilder<CarniceriaBloc, CarniceriaState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.summaries.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Nº ${state.summaries[index]}  ', style: TextStyle(fontSize: 16)),
                          Switch(
                            value: state.options[index],
                            onChanged: (value) {
                              context.read<CarniceriaBloc>().add(ToggleOption(index));
                            },
                          ),
                        ],
                      ),
                    );
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
