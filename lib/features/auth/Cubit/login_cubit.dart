import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/network/api_error.dart';
import 'package:graduationproject/features/auth/Cubit/auth_state.dart';
import 'package:graduationproject/features/auth/data/auth_repo.dart';
 

class LoginCubit extends Cubit<AuthState> {
  LoginCubit() : super(InitialState());

  AuthRepo authRepo = AuthRepo();

  Future<void> login({required String phone, required String password}) async {
    emit(LoadingState());
    try {
      final result = await authRepo.login(phone, password);
      
      emit(SuccessState());
    } catch (e) {
      if (e is ApiError) {
        emit(ErrorState(message: e.message)); 
      } else {
        emit(ErrorState(message: e.toString()));  
      }
    }
  }
}
