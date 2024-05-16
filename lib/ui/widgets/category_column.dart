import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../structure/bloc/carniceria/carniceria_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_event.dart';
import '../../structure/bloc/carniceria/carniceria_state.dart';

class CategoryColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CarniceriaBloc, CarniceriaState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1, // Makes the buttons square
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    _buildButton(context, 'Avicola', 0, state),
                    _buildButton(context, 'Porc', 1, state),
                    _buildButton(context, 'Me / Cordero', 2, state),
                    _buildButton(context, 'Tallat / Desfet', 3, state),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: _buildSwitch(context, 'CARNICERIA'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, int index, CarniceriaState state) {
    bool isSelected = state.options[index];
    Color color = isSelected ? Colors.green : Colors.grey;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(100, 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      onPressed: () {
        context.read<CarniceriaBloc>().add(ToggleOption(index));
      },
      child: Text(text, textAlign: TextAlign.center),
    );
  }

  Widget _buildSwitch(BuildContext context, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        Switch(
          value: true,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
