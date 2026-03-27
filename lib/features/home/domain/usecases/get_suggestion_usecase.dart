import '../repositories/complaint_repository.dart';

class GetSuggestionUseCase {
  final ComplaintRepository repository;

  GetSuggestionUseCase(this.repository);

  Future<List<String>> call(String text) async {
    return await repository.getSuggestion(text);
  }
}