import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject3/core/di/service_locator.dart';
import 'package:graduationproject3/core/network/api_error.dart';
import 'package:graduationproject3/features/auth/Cubit/auth_state.dart';
import 'package:graduationproject3/features/auth/data/auth_repo.dart';

class SignupCubit extends Cubit<AuthState> {
  SignupCubit() : super(InitialState());

  final AuthRepo _authRepo = sl<AuthRepo>();

  Future<void> signup({
    required String name,
    required String confirmPassword,
    required String password,
    required String email,
    required int ssn,
    required String phoneNumber,
  }) async {
    try {
      emit(LoadingState());
      await _authRepo.signup(
        name: name,
        confirmPassword: confirmPassword,
        phoneNumber: phoneNumber,
        password: password,
        email: email,
        ssn: ssn,
      );
      emit(SuccessState());
    } catch (e) {
      if (e is ApiError) {
        emit(ErrorState(message: e.message));
      } else {
        emit(ErrorState(message: e.toString()));
      }
    }
  }

  Future<void> sendOtp({required String phone}) async {
    try {
      await _authRepo.sendOtp(phone);

      emit(SendOtpSuccess());
    } catch (e) {
      if (e is ApiError) {
        emit(SendOtpError( e.message));
      } else {
        emit(SendOtpError( e.toString()));
      }
    }
  }

  Future<void> verifyOtp({required String phone, required String code}) async {
    try {
      emit(VerifyOtpLoading());
      await _authRepo.verifyOtp(phone, code);

      emit(VerifyOtpSuccess());
    } catch (e) {
      if (e is ApiError) {
        emit(VerifyOtpError( e.message));
      } else {
        emit(VerifyOtpError( e.toString()));
      }
    }
  }
}
