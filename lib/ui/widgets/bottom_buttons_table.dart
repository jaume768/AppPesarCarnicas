import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.only(right: 90.0), // Margen a la derecha de todo el conjunto de botones
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 50), // Aumenta el margen entre los botones
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Multi Pes', style: TextStyle(color: Colors.black, fontSize: 24)), // Tamaño de letra aumentado
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  minimumSize: Size(100, 100), // Botones cuadrados
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0), // Bordes cuadrados
                  ),
                  side: BorderSide(color: Colors.black, width: 1), // Borde negro de 2 píxeles
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centrar el texto verticalmente
                children: [
                  Text('Aceptar Pesada,', style: TextStyle(color: Colors.black, fontSize: 24)), // Tamaño de letra aumentado
                  Text('gravar, imprimir', style: TextStyle(color: Colors.black, fontSize: 24)), // Tamaño de letra aumentado
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: Size(200, 100), // Tamaño del botón
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Bordes cuadrados
                ),
                side: BorderSide(color: Colors.black, width: 1), // Borde negro de 2 píxeles
              ),
            ),
          ],
        ),
      ),
    );
  }
}
