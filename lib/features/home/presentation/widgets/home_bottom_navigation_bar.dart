import 'package:flutter/material.dart';
import 'package:graduationproject/features/Profile/views/profile_view.dart';

import '../../../../core/theme/app_colors.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 24,
      type: BottomNavigationBarType.fixed,

      selectedItemColor: AppColors.selected,
      unselectedItemColor:AppColors.unselected ,

      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined,), label: "حسابك"),
        BottomNavigationBarItem(icon: Icon(Icons.map,), label: "الخريطة"),

        BottomNavigationBarItem(icon: Icon(Icons.campaign_outlined ,), label: "الشكاوي"),
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined,), label: "الرئيسية"),

      ],
      currentIndex: 3,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ProfileView()),
          );
        }

      },
      selectedLabelStyle: const TextStyle(fontFamily: 'Alamari'),
      unselectedLabelStyle: const TextStyle(fontFamily: 'Alamari'),
    );
  }
}
