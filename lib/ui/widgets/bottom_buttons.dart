import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.check),
          label: Text('Aceptar'),
        ),
      ],
    );
  }
}
