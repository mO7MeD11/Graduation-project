class AnalysisResponseModel {
  final int valid;
  final String category;
  final String priority;

  AnalysisResponseModel({
    required this.valid,
    required this.category,
    required this.priority,
  });

  factory AnalysisResponseModel.fromJson(Map<String, dynamic> json) {
    return AnalysisResponseModel(
      valid: json['valid'] ?? 0,
      category: json['category'] ?? '',
      priority: json['priority'] ?? '',
    );
  }
}