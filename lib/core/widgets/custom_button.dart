import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/app_colors.dart';
import 'package:graduationproject/core/style/font_style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final bool isLoading;
  final IconData? icon;
  final bool isOutlined;

  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 54,
    this.borderRadius = 12,
    this.isLoading = false,
    this.icon,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isOutlined ? Colors.transparent : (backgroundColor ?? AppColors.primaryDark);
    final txtColor = isOutlined ? (textColor ?? AppColors.primaryDark) : (textColor ?? Colors.white);
    final borderColor = isOutlined ? (textColor ?? AppColors.primaryDark) : null;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: txtColor,
          elevation: isOutlined ? 0 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: isOutlined ? BorderSide(color: borderColor ?? AppColors.primaryDark, width: 1.8) : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: isLoading
            ? const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 22),
              const SizedBox(width: 10),
            ],
            Text(
              text,
              style: FontStyles.regular20.copyWith(
                color: txtColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}