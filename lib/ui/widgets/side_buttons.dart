import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideButtons extends StatelessWidget {
  final VoidCallback onFilterClient;
  final VoidCallback onClearFilter;

  const SideButtons({required this.onFilterClient, required this.onClearFilter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('REVISAR COMPLET', style: TextStyle(color: Colors.black, fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              minimumSize: Size(double.infinity, 60),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANVIAR CONFIGURACIÓ', style: TextStyle(color: Colors.black, fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              minimumSize: Size(double.infinity, 60),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: onFilterClient,
            child: Text('FILTRAR CLIENT', style: TextStyle(color: Colors.black, fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              minimumSize: Size(double.infinity, 60),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text('MARCAR PENDENT', style: TextStyle(color: Colors.black, fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              minimumSize: Size(double.infinity, 60),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text('PES PRODUCTE', style: TextStyle(color: Colors.black, fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: Size(double.infinity, 60),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text('ENVIAR FINAL', style: TextStyle(color: Colors.black, fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              minimumSize: Size(double.infinity, 60),
            ),
          ),
        ],
      ),
    );
  }
}