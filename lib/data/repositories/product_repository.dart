
import '../../models/client.dart';
import '../services/api_service.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository({required this.apiService});

  Future<List<Client>> getProductList(String productType, bool butchery, List<int> summaries) async {
    return await apiService.fetchProductList(productType, butchery, summaries);
  }
}
