import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/style/font_style.dart';

Widget _buildInfoCard({
  required String label,
  required String value,
}) {
  return Container(
    width: double.infinity, // عشان ياخد عرض الشاشة كلها
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    margin: const EdgeInsets.only(bottom: 16), // مسافة تحت كل كارت
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey[300]!, width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // العنوان (الليبل) فوق
        Text(
          label,
          style: FontStyles.regular16.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        // القيمة تحت العنوان
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