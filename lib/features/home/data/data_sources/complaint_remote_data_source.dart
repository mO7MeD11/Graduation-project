import 'package:dio/dio.dart';

class ComplaintRemoteDataSource {
  final Dio dio;

  ComplaintRemoteDataSource(this.dio);

  Future<void> submitComplaint(
      String text,
      double lat,
      double lng,
      ) async {
    try {
      await dio.post(
        'https://rana-07-rased.hf.space/predict',

        data: {
          'text': text,
          'lat': lat,
          'lng': lng,
        },

      );
    } catch (e) {
      throw Exception('Failed to submit complaint: $e');
    }
  }

  Future<List<String>> getSuggestion(String text) async {
    try {
      final response = await dio.post(
        'https://adria-superchivalrous-remonstratively.ngrok-free.dev/complete',
        queryParameters: {
          'prompt': text,
        },
      );

      final data = response.data;

      final suggestions = data['suggestions'];

      if (suggestions is List) {
        return List<String>.from(suggestions);
      }

      return [];
    } catch (e) {
      throw Exception('Failed to get suggestions: $e');
    }
  }
}