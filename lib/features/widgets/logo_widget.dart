import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final String logoPath;
  final double size;

  const LogoWidget({
    super.key,
    required this.logoPath,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      logoPath,
      width: size,
      height: size,
    );
  }
}