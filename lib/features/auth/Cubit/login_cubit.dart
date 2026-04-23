import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject3/core/di/service_locator.dart';
import 'package:graduationproject3/core/network/api_error.dart';
import 'package:graduationproject3/features/auth/Cubit/auth_state.dart';
import 'package:graduationproject3/features/auth/data/auth_repo.dart';

class LoginCubit extends Cubit<AuthState> {
  LoginCubit() : super(InitialState());

  final AuthRepo authRepo = sl<AuthRepo>();

  Future<void> login({required String phone, required String password}) async {
    emit(LoadingState());
    try {
      await authRepo.login(phone, password);
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
