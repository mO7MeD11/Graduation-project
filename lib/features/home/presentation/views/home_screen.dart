import 'package:flutter/material.dart';
import '../widgets/home_bottom_navigation_bar.dart';
import '../widgets/home_card_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: HomeCardList(),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(),
    );
  }
}
