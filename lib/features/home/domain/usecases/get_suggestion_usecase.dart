import '../repositories/ai_repository.dart';

class GetSuggestionUseCase {
  final AiRepository repository;

  GetSuggestionUseCase(this.repository);

  Future<List<String>> call(String text) {
    return repository.autocomplete(text);
  }
}