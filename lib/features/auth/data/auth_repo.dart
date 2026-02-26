import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:graduationproject/core/network/api_error.dart';
import 'package:graduationproject/core/network/api_exception.dart';
import 'package:graduationproject/core/network/api_service.dart';
import 'package:graduationproject/core/utils/pref_helper.dart';
import 'package:graduationproject/features/auth/data/user_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  UserModel? currentUser;

  Future<UserModel> signup({
    required String name,
    required String phon,

    required String password,
    required String confirmPassword,
    required int ssn,
  }) async {
    try {
      var response = await apiService.post('/api/Account/register', {
        "fullName": name,
        "phoneNumber": phon,
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

  Future<UserModel> login(String phone, String password) async {
    try {
      var response = await apiService.post('/api/Account/Login', {
        'phoneNumber': phone,
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

  Future<bool> sendOtp(String phone) async {
    try {
      var response = await apiService.post('/api/Account/send-otp', {
        'phoneNumber': phone,
      });

      return response['success'] == true;
    } on DioException catch (e) {
      throw ApiException.handelError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
