import 'package:flutter/material.dart';
import '../widgets/category_column.dart';
import '../widgets/actions_column.dart';
import '../widgets/summary_column.dart';
import '../widgets/bottom_buttons.dart';

class CarniceriaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(height: 10),
                  CategoryColumn(),
                  SizedBox(width: 10),
                  ActionsColumn(),
                  SizedBox(width: 10),
                  SummaryColumn(),
                ],
              ),
            ),
            BottomButtons(),
          ],
        ),
      ),
    );
  }
}
