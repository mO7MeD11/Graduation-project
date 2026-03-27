abstract class ComplaintRepository {
  Future<void> submitComplaint({
    required String text,
    required double lat,
    required double lng,
  });

  Future<List<String>> getSuggestion(String text);
}