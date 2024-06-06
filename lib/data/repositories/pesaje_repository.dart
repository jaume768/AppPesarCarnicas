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

  Future<Map<String, dynamic>> getArticleWeight(int articleId) async {
    try {
      return await apiService.fetchArticleWeight(articleId);
    } catch (e) {
      throw Exception('Failed to get article weight: $e');
    }
  }

  Future<Map<String, dynamic>> sendArticleWeight({
    required int articleId,
    required double weight,
    required double accumulatedWeight,
    required int clientCode,
  }) async {
    try {
      return await apiService.sendArticleWeight(
        articleId: articleId,
        weight: weight,
        accumulatedWeight: accumulatedWeight,
        clientCode: clientCode,
      );
    } catch (e) {
      throw Exception('Failed to send article weight: $e');
    }
  }
}
