import '../../models/client.dart';
import '../services/api_service.dart';

class PesajeRepository {
  final ApiService apiService;

  PesajeRepository({required this.apiService});

  Future<List<Client>> getProductList(String productType, bool butchery, List<int> summaries) async {
    try {
      return await apiService.fetchProductList(productType, butchery, summaries);
    } catch (e) {
      throw Exception('Failed to get product list: $e');
    }
  }

  Future<Map<String, dynamic>> getPesajeZero() async {
    try {
      return await apiService.fetchPesajeZero();
    } catch (e) {
      throw Exception('Failed to get pesaje zero: $e');
    }
  }

  Future<Map<String, dynamic>> getPesajeInestable() async {
    try {
      return await apiService.fetchPesajeInestable();
    } catch (e) {
      throw Exception('Failed to get pesaje inestable: $e');
    }
  }

  Future<Map<String, dynamic>> getPesajeEstable() async {
    try {
      return await apiService.fetchPesajeEstable();
    } catch (e) {
      throw Exception('Failed to get pesaje estable: $e');
    }
  }
}
