import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'selection_dialog.dart';

class ActionButton extends StatelessWidget {
  final BuildContext context;
  final String text;
  final String displayText;
  final Color color;
  final bool? isScale;
  final VoidCallback? onPressed;

  const ActionButton({
    required this.context,
    required this.text,
    required this.displayText,
    required this.color,
    this.isScale,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 182,
      height: 182, // Fixed height for buttons
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: color,
          minimumSize: Size(0, 0), // Minimum size to 0 to ensure it's square
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        onPressed: onPressed ?? () {
          if (isScale != null) {
            showSelectionDialog(context, isScale!);
          }
        },
        child: Center(
          child: Text(
            displayText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 21), // Adjust text size as needed
          ),
        ),
      ),
    );
  }
}
