import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graduationproject/core/style/font_style.dart';
import 'package:graduationproject/features/auth/views/login_view.dart';
import 'package:graduationproject/features/auth/widget/custom_container.dart';
import 'package:graduationproject/features/auth/widget/roale_card.dart';

class AccountTypeView extends StatelessWidget {
  const AccountTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE8E8E8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Gap(100),
            Image.asset('assets/rased.png'),
            Text('مر حبا في راصد', style: FontStyles.regular24),
            Text('اختر نوع الحساب  ', style: FontStyles.regular15),
            Gap(70),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                );
              },
              child: RoleCard(
                image: 'assets/person.svg',
                text1: 'راكب',
                text2: 'للابلاغ ومتابعة الشكاوي',
                color: 0xff778B94DE,
              ),
            ),
            Gap(18),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                );
              },
              child: RoleCard(
                image: 'assets/car.svg',
                text1: 'سواق',
                text2: 'لمتابعة الحالة والامتثال',
                color: 0xffFFF4A0,
              ),
            ),
            Gap(35),
            CustomContainer(),
          ],
        ),
      ),
    );
  }
}
