import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:graduationproject3/core/network/api_error.dart';
import 'package:graduationproject3/core/network/api_exception.dart';
import 'package:graduationproject3/core/network/api_service.dart';
import 'package:graduationproject3/core/utils/pref_helper.dart';
import 'package:graduationproject3/features/auth/data/user_model.dart';

class AuthRepo {
  final ApiService apiService;
  UserModel? currentUser;

  AuthRepo(this.apiService);

  Future<UserModel> signup({
    required String name,
    required String email,
    required String phoneNumber,

    required String password,
    required String confirmPassword,
    required int ssn,
  }) async {
    try {
      var response = await apiService.post('/api/Account/register', {
        "fullName": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "confirmPassword": confirmPassword,
        "ssn": ssn,
      });
      log("SUCCESS: $response");
      final user = UserModel.fromjson(response);
      PrefHelper.saveToken(user.token);

      currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiException.handelError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<UserModel> login(String email, String password) async {
    try {
      var response = await apiService.post('/api/Account/Login', {
        'email': email,
        'password': password,
      });

      final user = UserModel.fromjson(response);
      PrefHelper.saveToken(user.token);

      currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiException.handelError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<bool> sendOtp(String email) async {
    try {
      var response = await apiService.post('/api/Account/send-otp', {
        'email': email,
      });

      return response['success'] == true;
    } on DioException catch (e) {
      throw ApiException.handelError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<void> verifyOtp(String email, String code) async {
    try {
      var response = await apiService.post('/api/Account/verify-otp', {
        'email': email,
        'code': code,
      });
    } on DioException catch (e) {
      throw ApiException.handelError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
