abstract class AiRepository {
  Future<List<String>> autocomplete(String text);
  Future<String> classifyIssue(String text);
}