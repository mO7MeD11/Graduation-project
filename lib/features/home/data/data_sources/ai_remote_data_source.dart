import '../../../../core/network/api_service.dart';
import '../models/analysis_response_model.dart';

class AiRemoteDataSource {
  final ApiService apiService;

  AiRemoteDataSource(this.apiService);
  Future<AnalysisResponseModel> classifyIssue(String text) async {
    final response = await apiService.post(
      '/analyze', // الـ Path بس
      {"text": text}, // لازم الكلمة تكون text
    );
    return AnalysisResponseModel.fromJson(response);
  }


  Future<List<String>> autocomplete(String text) async {
    final response = await apiService.post(
      '/complete',
      {
        "prompt": text,
        "n_suggestions": 3,
      },
    );

    print("🔥 AUTOCOMPLETE RAW RESPONSE: $response");

    // Case 1: List مباشرة
    if (response is List) {
      return response.map((e) => e.toString()).toList();
    }

    // Case 2: Map response
    if (response is Map) {
      if (response['suggestions'] is List) {
        return List<String>.from(response['suggestions']);
      }

      if (response['result'] is String) {
        return [response['result']];
      }
    }

    return [];
  }

  Future<List<String>> getSuggestion(String text) async {
    return autocomplete(text);
  }
}
