import 'dart:convert';

import 'package:flutter/material.dart';
import '../../data/services/api_service.dart';
import '../widgets/category_column.dart';
import '../widgets/actions_column.dart';
import '../widgets/summary_column.dart';
import '../widgets/bottom_buttons.dart';

class CarniceriaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiService = ApiService(baseUrl: 'http://10.0.2.2:3000'); // Crea una instancia del servicio API

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
                  SizedBox(width: 30),
                  ActionsColumn(),
                  SizedBox(width: 30),
                  SummaryColumn(),
                ],
              ),
            ),
            BottomButtons(apiService: apiService), // Pasa la instancia del servicio API a BottomButtons
          ],
        ),
      ),
    );
  }
}
