class AuthState {}

class InitialState extends AuthState {}

class LoadingState extends AuthState {}

class SuccessState extends AuthState {}

class ErrorState extends AuthState {
  final String message;

  ErrorState({required this.message});
}

class activation extends AuthState {}
