import '../repositories/ai_repository.dart';

class ClassifyIssueUseCase {
  final AiRepository repo;

  ClassifyIssueUseCase(this.repo);

  Future<String> call(String text) {
    return repo.classifyIssue(text);
  }
}