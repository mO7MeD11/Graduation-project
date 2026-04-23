import 'package:flutter/material.dart';

import 'package:graduationproject3/core/constants/app_colors.dart';
import 'package:graduationproject3/core/style/font_style.dart';
import 'package:graduationproject3/core/widgets/custom_button.dart';
import 'package:graduationproject3/features/home/presentation/views/home_screen.dart';

import '../../onboarding/views/splash_view.dart';

class UserProfile {
  final String name;
  final String email;
  final String? profileImageUrl;
  final String nationalId;
  final String phone;
  final String role;

  const UserProfile({
    required this.name,
    required this.email,
    this.profileImageUrl,
    required this.nationalId,
    required this.phone,
    required this.role,
  });

  static UserProfile get current {
    return const UserProfile(
      name: 'محمد أحمد',
      email: 'mohamed@example.com',
      nationalId: '2900010123456',
      phone: '01012345678',
      role: 'راكب',
      profileImageUrl: null,
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserProfile.current;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        // نقلنا السهم للناحية التانية (الشمال في حالة الـ RTL)
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 15.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios, // سهم بشكل أشيك واتجاه صح
                color: Colors.black,
                size: 24,
              ),
              onPressed: () {
                // العودة للصفحة الرئيسية
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // صورة البروفايل بمقاس مرن
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.orangeAccent, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: screenHeight * 0.07, 
                    backgroundColor: Colors.grey[200],
                    backgroundImage: user.profileImageUrl != null
                        ? NetworkImage(user.profileImageUrl!)
                        : null,
                    child: user.profileImageUrl == null
                        ? Icon(Icons.person, size: screenHeight * 0.08, color: Colors.grey)
                        : null,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  user.name,
                  style: FontStyles.regular24.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  user.email,
                  style: FontStyles.regular16.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                _buildInfoCard(label: 'الرقم القومي', value: user.nationalId),
                const SizedBox(height: 12),

                _buildInfoCard(label: 'رقم الهاتف', value: user.phone),
                const SizedBox(height: 12),

                _buildInfoCard(label: 'الدور', value: user.role),

                SizedBox(height: screenHeight * 0.06),

                CustomButton(
                  text: 'تسجيل الخروج',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم تسجيل الخروج بنجاح')),
                    );

                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const SplashScreen()),
                        (route) => false,
                      );
                    });
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String label,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: FontStyles.regular15.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: FontStyles.regular15.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
