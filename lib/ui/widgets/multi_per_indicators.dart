import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../structure/bloc/products/products_bloc.dart';
import '../../structure/bloc/products/products_state.dart';

class MultiPesIndicators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.showMultiPesIndicators) ...[
                _buildIndicator('0', Colors.yellow),
                SizedBox(width: 10),
              ],
              if (state.showMultiPesIndicators) ...[
                SizedBox(width: 10),
                _buildIndicator('0', Colors.green),
              ],
              SizedBox(width: 10),
              _buildIndicator('0,00', Colors.green.shade200),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildIndicator(String text, Color color, {IconData? icon}) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: icon != null
          ? Column(
        children: [
          Icon(icon, color: Colors.black),
          Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      )
          : Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 31),
        textAlign: TextAlign.center,
      ),
    );
  }
}
