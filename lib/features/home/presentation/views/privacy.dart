import 'package:flutter/material.dart';
import 'package:graduationproject3/core/constants/app_colors.dart';
import 'package:graduationproject3/core/style/font_style.dart';
import 'package:graduationproject3/features/home/presentation/views/home_screen.dart';

class LegalInfoScreen extends StatelessWidget {
  const LegalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 22),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // الهيدر الرئيسي (الأيقونة فوق العنوان)
                        Center(
                          child: Column(
                            children: [
                              const Icon(Icons.privacy_tip_outlined, size: 45, color: Colors.black),
                              const SizedBox(height: 12),
                              Text(
                                'معلومات قانونية',
                                style: FontStyles.regular24.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'سياسة الخصوصية، والشروط والأحكام الخاصة بمنصة راصد',
                                textAlign: TextAlign.center,
                                style: FontStyles.regular15.copyWith(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),

                        _buildLegalCard(
                          title: 'سياسة الخصوصية',
                          content:
                              'نحن في منصة "راصد" نلتزم بأعلى معايير الخصوصية والأمان لحماية بياناتك الشخصية والمعلومات التي تشاركها معنا. نقوم بجمع المعلومات الضرورية فقط لتقديم خدماتنا مثل رقم الجوال، الموقع الجغرافي عند تقديم البلاغ، والصور المرفقة.',
                          icon: Icons.security_outlined,
                        ),
                        const SizedBox(height: 20),

                        _buildLegalCard(
                          title: 'الشروط والأحكام',
                          content:
                              'باستخدامك تطبيق "راصد" فإنك توافق على الالتزام بالشروط والأحكام الموضحة هنا لضمان سلامة الجميع. يجب أن تكون جميع البلاغات المقدمة دقيقة وحقيقية وتخدم المصلحة العامة.',
                          icon: Icons.gavel_outlined,
                        ),

                        // Spacer عشان يزق "العودة إلى الرئيسية" لتحت خالص
                        const Spacer(),

                        const SizedBox(height: 30),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const HomeScreen()),
                                (route) => false,
                              );
                            },
                            child: Text(
                              'العودة إلي الرئيسية',
                              style: FontStyles.regular18.copyWith(
                                color: Colors.black87,

                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLegalCard({required String title, required String content, required IconData icon}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black, size: 24),
              const SizedBox(width: 10),
              Text(
                title,
                style: FontStyles.regular18.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: FontStyles.regular15.copyWith(
              height: 1.6,
              color: AppColors.privacyText, // اللون #06223D
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
