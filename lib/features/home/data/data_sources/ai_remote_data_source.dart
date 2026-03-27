import 'package:dio/dio.dart';

class AiRemoteDataSource {
  final Dio dio;

  AiRemoteDataSource(this.dio);

  Future<List<String>> autocomplete(String text) async {
    final response = await dio.post(
      "YOUR_AUTOCOMPLETE_API",
      data: {"text": text},
    );

    return List<String>.from(response.data["suggestions"]);
  }

  Future<String> classifyIssue(String text) async {
    final response = await dio.post(
      "YOUR_CLASSIFY_API",
      data: {"text": text},
    );

    return response.data["label"];
  }
}