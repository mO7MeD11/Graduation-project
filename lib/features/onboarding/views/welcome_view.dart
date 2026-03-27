import 'package:flutter/material.dart';
import 'package:graduationproject/features/home/presentation/views/home_screen.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/style/font_style.dart';
import '../../../core/widgets/custom_button.dart';
import '../../home/presentation/views/home_screen.dart';
import '../../registration/views/account_type_view.dart';
import '../../widgets/logo_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),

                const LogoWidget(
                  logoPath: 'assets/images/rasedlogo.png',
                  size: 140,
                ),

                const SizedBox(height: 48),

                Text(
                  'منصة التنسيق والتشكاوى الذكي',
                  style: FontStyles.regular24.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                Text(
                  'أبلغ عن أي شيء تعتقد أنه سيء في مواصلاتك اليومية',
                  style: FontStyles.regular16.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),

                const Spacer(flex: 3),


                CustomButton(
                  text: 'تابع',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const AccountTypeView()),
                    );
                  },
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}