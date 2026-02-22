import 'package:flutter/material.dart';
import 'package:graduationproject/core/style/font_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onTap});
  final String text;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(color: Color(0xff06223D)),
        child: Center(
          child: Text(
            text,
            style: FontStyles.regular20.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
