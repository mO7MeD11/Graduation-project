import 'dart:convert';
import 'dart:developer';

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
    final statusCode = error.response?.statusCode?.toString();
    final data = error.response?.data;

    String msg = 'حدث خطأ غير معروف';

    if (data != null) {
      try {
        Map<String, dynamic> decoded = data is Map<String, dynamic>
            ? data
            : json.decode(data.toString());

        if (decoded.containsKey('errors')) {
          final errors = decoded['errors'] as Map<String, dynamic>;
          if (errors.isNotEmpty) {
            var firstError = errors.entries.first.value;
            if (firstError is List && firstError.isNotEmpty) {
              msg = firstError.first.toString();
            } else {
              msg = firstError.toString();
            }
          }
        } else if (decoded.containsKey('message')) {
          msg = decoded['message'].toString();
        }
      } catch (_) {
        msg = data.toString();
      }
    }

    return ApiError(message: msg, statusCode: statusCode);
  }
}
