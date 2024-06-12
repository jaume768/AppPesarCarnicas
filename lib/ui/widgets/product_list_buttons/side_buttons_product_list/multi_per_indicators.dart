import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../structure/bloc/pesaje/pesaje_bloc.dart';
import '../../../../structure/bloc/pesaje/pesaje_state.dart';

class MultiPesIndicators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PesajeBloc, PesajeState>(
      builder: (context, pesajeState) {
        String weightText = pesajeState.weight?.toStringAsFixed(2) ?? '0.00';
        String accumulatedWeightText = pesajeState.accumulatedWeight.toStringAsFixed(2);
        String countText = pesajeState.count.toString();
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIndicator(accumulatedWeightText, Colors.yellow, width: 120),
            SizedBox(width: 10),
            _buildIndicator(countText, Colors.green, width: 70),
            SizedBox(width: 10),
            _buildIndicator(weightText, Colors.green.shade200, width: 120),
          ],
        );
      },
    );
  }

  Widget _buildIndicator(String text, Color color, {double width = 60}) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(10.0),
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 31),
        textAlign: TextAlign.center,
      ),
    );
  }
}
