import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('Multi Pes', style: TextStyle(color: Colors.black, fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              minimumSize: Size(150, 60),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            child: Column(
              children: [
                Text('Aceptar Pesada,', style: TextStyle(color: Colors.black, fontSize: 18)),
                Text('gravar, imprimir', style: TextStyle(color: Colors.black, fontSize: 18)),
              ],
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              minimumSize: Size(200, 60),
            ),
          ),
        ],
      ),
    );
  }
}