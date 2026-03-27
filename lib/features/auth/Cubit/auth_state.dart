class AuthState {}

class InitialState extends AuthState {}

class LoadingState extends AuthState {}

class SuccessState extends AuthState {}

 

 

class ErrorState extends AuthState {
  final String message;

  ErrorState({required this.message});
}

class activation extends AuthState {}


class SendOtpLoading extends AuthState {}

class SendOtpSuccess extends AuthState {}

class SendOtpError extends AuthState {
  final String message;
  SendOtpError(this.message);
}

/// Verify OTP
class VerifyOtpLoading extends AuthState {}

class VerifyOtpSuccess extends AuthState {}

class VerifyOtpError extends AuthState {
  final String message;
  VerifyOtpError(this.message);
}
