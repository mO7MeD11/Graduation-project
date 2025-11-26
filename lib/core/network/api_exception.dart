import 'package:dio/dio.dart';
import 'package:graduationproject/core/network/api_error.dart';


class ApiException {
  static ApiError handelError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: 'connectionTimeout');
      case DioExceptionType.sendTimeout:
        return ApiError(message: 'sendTimeout');
      case DioExceptionType.receiveTimeout:
        return ApiError(message: 'receiveTimeout');
      case DioExceptionType.badCertificate:
        return ApiError(message: 'badCertificate');
      case DioExceptionType.badResponse:
        return messageError(error);
      case DioExceptionType.cancel:
        return ApiError(message: 'cancel');
      case DioExceptionType.connectionError:
        return ApiError(message: 'connectionError');
      case DioExceptionType.unknown:
        return ApiError(message: 'there was an error');
    }
  }

  static ApiError messageError(DioException error) {
    final data = error.response!.data;
    if (error.response != null &&
        error.response?.data is Map<String, dynamic>) {
      return ApiError(message: data['message'] ?? 'حدث خطأ غير معروف');
    } else {
      return data is Map<String, dynamic>
          ? ApiError(message: data['message'])
          : ApiError(message: '${data}');
    }
  }
}
