import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor ;
  final VoidCallback onTap;

  const HomeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 43, color: iconColor),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Alamari',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
        Text(
          subtitle,
          style: const TextStyle(
            fontFamily: 'Alamari',
            fontSize: 14,
            color: Colors.grey,
            ),
        )
          ],
        ),
      ),
    );
  }
}
