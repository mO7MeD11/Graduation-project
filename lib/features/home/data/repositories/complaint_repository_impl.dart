import '../../domain/repositories/complaint_repository.dart';
import '../data_sources/complaint_remote_data_source.dart';

class ComplaintRepositoryImpl implements ComplaintRepository {
  final ComplaintRemoteDataSource remote;

  ComplaintRepositoryImpl(this.remote);

  @override
  Future<void> submitComplaint({
    required String text,
    required double lat,
    required double lng,
  }) {
    return remote.submitComplaint(
      text,
      lat,
      lng,
    );
  }

  @override
  Future<List<String>> getSuggestion(String text) {
    return remote.getSuggestion(text);
  }
}