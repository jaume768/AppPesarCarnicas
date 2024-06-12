import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../data/services/api_service.dart';
import '../widgets/configuration_buttons/category_column.dart';
import '../widgets/configuration_buttons/actions_column.dart';
import '../widgets/configuration_buttons/summary_column.dart';
import '../widgets/configuration_buttons/bottom_buttons.dart';

class CarniceriaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiService = ApiService(baseUrl: dotenv.env['BASE_URL']!);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  const SizedBox(height: 10),
                  const CategoryColumn(),
                  const SizedBox(width: 30),
                  ActionsColumn(),
                  const SizedBox(width: 30),
                  const SummaryColumn(),
                ],
              ),
            ),
            BottomButtons(apiService: apiService),
          ],
        ),
      ),
    );
  }
}
