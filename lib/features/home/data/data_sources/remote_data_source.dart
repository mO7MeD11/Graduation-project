import 'package:dio/dio.dart';

class ComplaintRemoteDataSource {
  final Dio dio;

  ComplaintRemoteDataSource(this.dio);

  Future<void> submitComplaint({
    required String title,
    required String description,
    required String category,
  }) async {
    await dio.post(
      'https://YOUR_API/api/Complaints',
      data: {
        "title": title,
        "description": description,
        "category": category,
      },
    );
  }
}