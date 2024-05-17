import '../services/api_service.dart';

class CarniceriaRepository {
  final ApiService apiService;

  CarniceriaRepository({required this.apiService});

  Future<List<int>> getSummaries(String productType, bool butchery) {
    return apiService.fetchSummaries(productType, butchery);
  }

  Future<List<dynamic>> getProductList(String productType, bool butchery, List<int> summaries) {
    return apiService.fetchProductList(productType, butchery, summaries);
  }
}
