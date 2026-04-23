import 'package:dio/dio.dart';
import 'package:graduationproject3/core/network/api_exception.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<dynamic> get(String endPoint) async {
    try {
      var response = await _dio.get(endPoint);
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw ApiException.handelError(e);
      } else {
        throw e.toString();
      }
    }
  }

  Future<dynamic> post(String endPoint, Map<String, dynamic> body) async {
    try {
      var response = await _dio.post(
        endPoint,
        data: body,
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw ApiException.handelError(e);
      } else {
        throw e.toString();
      }
    }
  }

  Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
    try {
      var response = await _dio.put(
        endPoint,
        data: body,
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw ApiException.handelError(e);
      } else {
        throw e.toString();
      }
    }
  }

  Future<dynamic> delete(String endPoint, Map<String, dynamic> body) async {
    try {
      var response = await _dio.delete(
        endPoint,
        data: body,
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw ApiException.handelError(e);
      } else {
        throw e.toString();
      }
    }
  }
}