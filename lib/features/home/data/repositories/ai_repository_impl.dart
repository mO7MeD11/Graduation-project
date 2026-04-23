import 'package:graduationproject3/features/home/data/data_sources/ai_remote_data_source.dart';
import 'package:graduationproject3/features/home/data/models/analysis_response_model.dart';
import 'package:graduationproject3/features/home/domain/repositories/ai_repository.dart';

class AiRepositoryImpl implements AiRepository {
  final AiRemoteDataSource remote;

  AiRepositoryImpl(this.remote);

  @override
  Future<AnalysisResponseModel> classifyIssue(String text) {
    return remote.classifyIssue(text);
  }

  @override
  Future<List<String>> autocomplete(String text) {
    return remote.autocomplete(text);
  }
}