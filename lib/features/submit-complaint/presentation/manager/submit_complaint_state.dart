abstract class SubmitComplaintState {}

class SubmitComplaintInitial extends SubmitComplaintState {}

class SubmitComplaintLoading extends SubmitComplaintState {}

class SubmitComplaintSuccess extends SubmitComplaintState {}

class SubmitComplaintError extends SubmitComplaintState {
  final String message;
  SubmitComplaintError({required this.message});
}

class AiAnalysisSuccess extends SubmitComplaintState {
  final String suggestion;
  final String category;
  final String priority;

  AiAnalysisSuccess({
    required this.suggestion,
    required this.category,
    required this.priority,
  });
}

class AiAnalysisError extends SubmitComplaintState {
  final String message;
  AiAnalysisError({required this.message});
}
