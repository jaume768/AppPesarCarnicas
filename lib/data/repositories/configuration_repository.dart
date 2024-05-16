import '../services/api_service.dart';

class ConfigurationRepository {
  final ApiService apiService;

  ConfigurationRepository({required this.apiService});

  Future<Map<String, List<dynamic>>> getConfiguration() {
    return apiService.fetchConfiguration();
  }
}
