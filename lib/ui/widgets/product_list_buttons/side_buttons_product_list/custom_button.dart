import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final double width;
  final double height;
  final double fontSize; // Nueva propiedad para el tamaño de fuente
  final VoidCallback? onPressed;

  const CustomButton({
    required this.text,
    required this.color,
    this.width = 175,
    this.height = 60,
    this.fontSize = 17, // Valor predeterminado para el tamaño de fuente
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            side: BorderSide(color: Colors.black, width: 1),
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: fontSize), // Usar el tamaño de fuente definido
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
