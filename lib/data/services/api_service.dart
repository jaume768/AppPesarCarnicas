import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<int>> fetchSummaries(String productType, bool butchery) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orderPreparation/summaries'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'productType': productType, 'butchery': butchery}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<int>.from(data['summaries']);
    } else {
      throw Exception('Failed to load summaries');
    }
  }
}
