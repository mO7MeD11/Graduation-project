import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/app_colors.dart';
import 'package:graduationproject/core/style/font_style.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool enabled;
  final bool readOnly;
  final FocusNode? focusNode;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.enabled = true,
    this.readOnly = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      focusNode: focusNode,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: FontStyles.regular16.copyWith(color: AppColors.textSecondary),
        hintStyle: FontStyles.regular16.copyWith(color: Colors.grey[500]),
        filled: true,
        fillColor: enabled ? Colors.black12 : Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon != null
            ? GestureDetector(
          onTap: onSuffixTap,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: suffixIcon,
          ),
        )
            : null,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryDark, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1.8),
        ),
      ),
      style: FontStyles.regular16.copyWith(color: AppColors.textPrimary),
    );
  }
}