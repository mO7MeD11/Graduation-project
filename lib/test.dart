import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AiTestPage extends StatefulWidget {
  const AiTestPage({super.key});

  @override
  State<AiTestPage> createState() => _AiTestPageState();
}

class _AiTestPageState extends State<AiTestPage> {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://ans2004-auto-completion.hf.space",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  final TextEditingController controller = TextEditingController();

  String output = "";
  bool loading = false;

  /// 🔥 AUTOCOMPLETE TEST
  Future<void> testAutocomplete() async {
    setState(() {
      loading = true;
      output = "Loading autocomplete...";
    });

    try {
      final res = await dio.post(
        "/complete",
        data: {
          "prompt": controller.text,
          "n_suggestions": 3,
        },
      );

      debugPrint("📥 AUTOCOMPLETE RAW: ${res.data}");

      setState(() {
        output = res.data.toString();
      });
    } catch (e) {
      debugPrint("❌ AUTOCOMPLETE ERROR: $e");
      setState(() {
        output = "ERROR: $e";
      });
    }

    setState(() => loading = false);
  }

  /// 🔥 ANALYZE TEST
  Future<void> testAnalyze() async {
    setState(() {
      loading = true;
      output = "Loading analysis...";
    });

    try {
      final res = await dio.post(
        "/analyze",
        data: {
          "text": controller.text,
        },
      );

      debugPrint("📥 ANALYSIS RAW: ${res.data}");

      setState(() {
        output = res.data.toString();
      });
    } catch (e) {
      debugPrint("❌ ANALYSIS ERROR: $e");
      setState(() {
        output = "ERROR: $e";
      });
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI TEST PAGE"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "اكتب أي جملة...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: loading ? null : testAutocomplete,
                    child: const Text("Test Autocomplete"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: loading ? null : testAnalyze,
                    child: const Text("Test Analyze"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (loading) const CircularProgressIndicator(),

            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  output,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}