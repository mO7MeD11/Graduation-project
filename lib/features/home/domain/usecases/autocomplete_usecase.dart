import '../repositories/ai_repository.dart';

class AutocompleteUseCase {
  final AiRepository repo;

  AutocompleteUseCase(this.repo);

  Future<List<String>> call(String text) {
    return repo.autocomplete(text);
  }
}