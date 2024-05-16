import 'package:flutter/material.dart';

class ActionsColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton(context, 'Seleccionar Báscula', Colors.lightBlue),
          _buildButton(context, 'Seleccionar Impresora', Colors.pink),
          _buildButton(context, 'Veure Totals x Article', Colors.red),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        onPressed: () {},
        child: Text(text),
      ),
    );
  }
}
