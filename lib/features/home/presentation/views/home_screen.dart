import 'package:flutter/material.dart';
import 'package:graduationproject3/features/home/domain/repositories/ad_repository.dart';
import 'package:graduationproject3/features/home/presentation/views/privacy.dart';
import 'package:graduationproject3/features/home/presentation/widgets/home_bottom_navigation_bar.dart';
import 'package:graduationproject3/features/home/presentation/widgets/home_card_list.dart';
import '../../../../core/di/service_locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> _adsFuture;

  final String baseUrl =
      "https://419443gt-7262.euw.devtunnels.ms"; // 🔥 الحل الأساسي

  @override
  void initState() {
    super.initState();

    print("🚀 API CALL START: getAds");

    _adsFuture = sl<AdRepository>().getAds().then((data) {
      print("✅ API SUCCESS: getAds");
      print("📦 DATA: $data");

      return data;
    }).catchError((error) {
      print("❌ API ERROR: $error");
      throw error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 🔴 Ads Banner
            FutureBuilder(
              future: _adsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print("❌ UI ERROR: ${snapshot.error}");

                  return _buildPlaceholder(
                    Center(
                      child: Text(
                        "Failed to load ads\n${snapshot.error}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildPlaceholder(
                    const Center(child: CircularProgressIndicator()),
                  );
                }

                final ads = snapshot.data ?? [];

                print("🖼️ Ads count: ${ads.length}");

                if (ads.isEmpty) {
                  return _buildPlaceholder(
                    const Center(child: Text("No Ads")),
                  );
                }

                return Container(
                  height: 80,
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(15, 30, 12, 0),
                  child: PageView.builder(
                    itemCount: ads.length,
                    itemBuilder: (context, index) {
                      final ad = ads[index];

                      // 🔥 تحويل localhost إلى devtunnel
                      final imageUrl = (ad.imageUrl ?? '')
                          .replaceFirst('https://localhost:7262', baseUrl)
                          .replaceFirst('http://localhost:7262', baseUrl);

                      print("🖼️ IMAGE URL: $imageUrl");

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            print("❌ IMAGE ERROR: $error");

                            return const Center(
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            // 📌 Main Content
             Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: HomeCardList(

                ),
              ),
            ),

            // 🔵 Privacy Policy
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LegalInfoScreen(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.safety_check_outlined,
                        size: 18, color: Colors.black),
                    SizedBox(width: 6),
                    Text(
                      'سياسة الخصوصية',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNavigationBar(),
    );
  }

  Widget _buildPlaceholder(Widget child) {
    return Container(
      height: 80,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(15, 30, 12, 0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
