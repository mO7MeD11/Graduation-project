import '../../domain/entities/complaint.dart';
import '../../domain/repositories/home_repository.dart';
import '../data_sources/home_remote_data_source.dart';
import '../models/complaint_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;

  HomeRepositoryImpl(this.remote);

  @override
  Future<void> submitComplaint(Complaint complaint) {
    final model = ComplaintModel(
      id: complaint.id,
      title: complaint.title,
      description: complaint.description,
      category: complaint.category, // ✅ لازم تضيفي دي
    );

    return remote.submitComplaint(model);
  }
}