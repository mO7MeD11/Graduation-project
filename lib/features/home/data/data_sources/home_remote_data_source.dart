import 'package:dio/dio.dart';
import '../models/complaint_model.dart';

class HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSource(this.dio);

  Future<void> submitComplaint(ComplaintModel complaint) async {
    await dio.post(
      "/complaints",
      data: complaint.toJson(),
    );
  }
}