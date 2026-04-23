import '../repositories/ai_repository.dart';
import '../../data/models/analysis_response_model.dart';

class ClassifyIssueUseCase {
  final AiRepository repo;

  ClassifyIssueUseCase(this.repo);

  Future<AnalysisResponseModel> call(String text) {
    return repo.classifyIssue(text);
  }
}