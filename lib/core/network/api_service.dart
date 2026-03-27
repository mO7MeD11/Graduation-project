import 'dart:convert' show jsonDecode;
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:graduationproject/core/network/api_exception.dart';
import 'package:graduationproject/core/network/dio_client.dart';

class ApiService {
  final DioClient _dio = DioClient();

  Future<dynamic> get(String endPoint) async {
    try {
      var response = await _dio.dio.get(endPoint);

      return response.data;
    } catch (e) {
      if (e is DioException) {
        return ApiException.handelError(e);
      } else {
        return e.toString();
      }
    }
  }

  Future<dynamic> post(String endPoint, Map<String, dynamic> body) async {
    try {
      var response = await _dio.dio.post(endPoint, data: body);
         
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
      var response = await _dio.dio.put(endPoint, data: body);

      return response.data;
    } catch (e) {
      if (e is DioException) {
        return ApiException.handelError(e);
      } else {
        return e.toString();
      }
    }
  }

  Future<dynamic> delete(String endPoint, Map<String, dynamic> body) async {
    try {
      var response = await _dio.dio.delete(endPoint, data: body);

      return response.data;
    } catch (e) {
      if (e is DioException) {
        return ApiException.handelError(e);
      } else {
        return e.toString();
      }
    }
  }
}
