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
                  childAspectRatio: 1,
                  mainAxisSpacing: 10,
                  padding: EdgeInsets.only(top: 40),
                  crossAxisSpacing: 10,
                  children: [
                    _buildButton(context, 'Avicola', 'POULTRY', state.selectedProductType),
                    _buildButton(context, 'Porc', 'PIG', state.selectedProductType),
                    _buildButton(context, 'Me / Cordero', 'LAMB', state.selectedProductType),
                    _buildButton(context, 'Tallat / Desfet', 'CHOPPED', state.selectedProductType),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: _buildSwitch(context, 'CARNICERIA    ', state.isButchery),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, String productType, String? selectedProductType) {
    bool isSelected = selectedProductType == productType;
    Color color = isSelected ? Colors.green : Colors.grey.shade300;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: color,
        minimumSize: Size(100, 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      onPressed: () {
        context.read<CarniceriaBloc>().add(FetchSummaries(productType));
      },
      child: Text(text, textAlign: TextAlign.center,),
    );
  }


  Widget _buildSwitch(BuildContext context, String text, bool isButchery) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(text),
        Switch(
          value: isButchery,
          onChanged: (value) {
            context.read<CarniceriaBloc>().add(ToggleButchery(value));
          },
        ),
      ],
    );
  }
}
