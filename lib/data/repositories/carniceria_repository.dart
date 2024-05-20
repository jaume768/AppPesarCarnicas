import '../../models/client.dart';
import '../services/api_service.dart';

class CarniceriaRepository {
  final ApiService apiService;

  CarniceriaRepository({required this.apiService});

  Future<List<int>> getSummaries(String productType, bool butchery) {
    return apiService.fetchSummaries(productType, butchery);
  }

  Future<List<Client>> getProductList(String productType, bool butchery, List<int> summaries) async {
    final response = await apiService.fetchProductList(productType, butchery, summaries);
    return response;
  }
}
