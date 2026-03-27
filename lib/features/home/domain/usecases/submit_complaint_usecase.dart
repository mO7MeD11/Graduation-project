import '../repositories/complaint_repository.dart';

class SubmitComplaintUseCase {
  final ComplaintRepository repository;

  SubmitComplaintUseCase(this.repository);

  Future<void> call({
    required String text,
    required double lat,
    required double lng,
  }) {
    return repository.submitComplaint(
      text: text,
      lat: lat,
      lng: lng,
    );
  }
}