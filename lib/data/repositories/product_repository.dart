import '../../models/client.dart';
import '../services/api_service.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository({required this.apiService});

  Future<List<Client>> getProductList(String productType, bool butchery, List<int> summaries) async {
    return await apiService.fetchProductList(productType, butchery, summaries);
  }

  Future<List<Map<String, dynamic>>> getArticleList(String productType) async {
    return await apiService.fetchArticleList(productType);
  }
}
