class ApiError {
  final String message;
  final String? statusCode;

  ApiError({required this.message,   this.statusCode});

  @override
  String toString() {
    return '$message with status Code $statusCode';
  }
}
