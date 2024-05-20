import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/client.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, List<dynamic>>> fetchConfiguration() async {
    final response = await http.post(
      Uri.parse('$baseUrl/orderPreparation/configuration'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'printers': List<dynamic>.from(data['printers']),
        'scales': List<dynamic>.from(data['scales']),
      };
    } else {
      throw Exception('Failed to load configuration');
    }
  }

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

  Future<List<Client>> fetchProductList(String productType, bool butchery, List<int> summaries) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orderPreparation/productList'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'productType': productType,
        'butchery': butchery,
        'summaries': summaries,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['clients'] as List)
          .map((clientJson) => Client.fromJson(clientJson))
          .toList();
    } else {
      throw Exception('Failed to load product list');
    }
  }
}
