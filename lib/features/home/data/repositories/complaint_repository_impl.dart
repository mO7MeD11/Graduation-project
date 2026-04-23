import '../../domain/entities/complaint.dart';
import '../../domain/repositories/complaint_repository.dart';
import '../data_sources/complaint_remote_data_source.dart';

class ComplaintRepositoryImpl implements ComplaintRepository {
  final ComplaintRemoteDataSource remoteDataSource;

  ComplaintRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> submitComplaint(Complaint complaint) {
    return remoteDataSource.submitComplaint(
      title: complaint.title,
      description: complaint.description,
      category: complaint.category,
    );
  }
}