import 'package:flutter/material.dart';

import 'package:graduationproject/core/constants/app_colors.dart';
import 'package:graduationproject/core/style/font_style.dart';
import 'package:graduationproject/core/widgets/custom_button.dart';

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

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only( top: 8.0,right:15.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_forward_sharp,
              color: Colors.black,
              size: 28,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),

      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 24),

              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.orangeAccent, width: 3),
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: user.profileImageUrl != null
                      ? NetworkImage(user.profileImageUrl!)
                      : null,
                  child: user.profileImageUrl == null
                      ? const Icon(Icons.person, size: 80, color: Colors.grey)
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

              const SizedBox(height: 40),

            _buildInfoCard(label: 'الرقم القومي', value: user.nationalId),
              const SizedBox(height: 16),

              _buildInfoCard(label: 'رقم الهاتف', value: user.phone),
              const SizedBox(height: 16),

              _buildInfoCard(label: 'الدور', value: user.role),

              const SizedBox(height: 60),


              CustomButton(
                text: 'تسجيل الخروج',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم تسجيل الخروج بنجاح')),
                  );
                },
              ),

              const SizedBox(height: 40),
            ],
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: FontStyles.regular16.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: FontStyles.regular20.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
