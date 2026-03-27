import '../../domain/repositories/ai_repository.dart';
import '../data_sources/ai_remote_data_source.dart';

class AiRepositoryImpl implements AiRepository {
  final AiRemoteDataSource remote;

  AiRepositoryImpl(this.remote);

  @override
  Future<List<String>> autocomplete(String text) {
    return remote.autocomplete(text);
  }

  @override
  Future<String> classifyIssue(String text) {
    return remote.classifyIssue(text);
  }
}