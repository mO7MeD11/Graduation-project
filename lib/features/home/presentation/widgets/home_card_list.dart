import 'package:flutter/material.dart';
import '../views/submit_complaint_view.dart';
import 'home_card.dart';

class HomeCardList extends StatelessWidget {
  const HomeCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 351,
            height: 235,
            child: HomeCard(
              title: "تقديم بلاغ",
              subtitle:"الابلاغ عن مخالفة مروريه" ,
              icon: Icons.campaign_outlined,
              iconColor:Colors.black,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SubmitComplaintScreen()),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 351,
            height: 235,
            child: HomeCard(
              title: "متابعة البلاغات",
              subtitle: "حالة الشكوي السابقه",
              icon: Icons.list,
              iconColor: const Color(0xFFFDEA5A),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
