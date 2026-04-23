import '../../data/models/analysis_response_model.dart';

abstract class AiRepository {
  Future<AnalysisResponseModel> classifyIssue(String text);

  Future<List<String>> autocomplete(String text);
}