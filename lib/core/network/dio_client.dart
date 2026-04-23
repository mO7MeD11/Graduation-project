import 'package:dio/dio.dart';
import 'api_costant.dart';

class DioClient {
  static Dio complaintsDio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.complaintsBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  static Dio aiDio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.aiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
}