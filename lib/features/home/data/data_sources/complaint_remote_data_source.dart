import '../../../../core/network/api_service.dart';
import '../../../../core/constants/api_constants.dart';

class ComplaintRemoteDataSource {
  final ApiService apiService;

  ComplaintRemoteDataSource(this.apiService);

  Future<void> submitComplaint({
    required String title,
    required String description,
    required String category,
    String? imagePath,
    double? lat,
    double? lng,
  }) async {
    await apiService.post(
      ApiConstants.complaints,
      {
        "title": title,
        "description": description,
        "category": category,
        "image": imagePath,
        "lat": lat,
        "lng": lng,
      },
    );
  }
}