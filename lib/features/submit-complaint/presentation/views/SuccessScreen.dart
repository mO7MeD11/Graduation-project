import 'package:flutter/material.dart';
import 'package:graduationproject3/core/constants/app_colors.dart';
import 'package:graduationproject3/core/theme/app_text_styles.dart';
import 'package:graduationproject3/core/widgets/custom_button.dart';
import 'package:graduationproject3/features/home/presentation/views/home_screen.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showButton = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline_outlined, size: 80, color: AppColors.success),
            const SizedBox(height: 16),
            const Text(
              "تم الإرسال بنجاح",
              style:AppTextStyles.title,            ),
            const Text(
              "شكرا لتعاونك سيتم مراجعة البلاغ و تخاد الاجراء اللازم ",
              style:AppTextStyles.subtitle,
            ),
            const SizedBox(height: 20),
            if (_showButton)
              CustomButton(
                text: "العودة للرئيسية",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
