import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:graduationproject/core/style/font_style.dart';

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
              onTap: () {},
              child: RoleCard(
                image: 'assets/person.svg',
                text1: 'راكب',
                text2: 'للابلاغ ومتابعة الشكاوي',
                color: 0xff778B94DE,
              ),
            ),
            Gap(18),
            GestureDetector(
              onTap: () {},
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

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Color(0xffFFFFFF)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'اتصال ظوارئ (1213)',
            style: TextStyle(
              color: Color(0xffFF0C0C),
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          Gap(8),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xffFFD0D0),
              borderRadius: BorderRadius.circular(15),
            ),
            child: SvgPicture.asset('assets/call.svg'),
          ),
        ],
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.text1,
    required this.text2,
    required this.image,
    required this.color,
  });
  final String text1;
  final String text2;
  final String image;
  final int color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Color(0xffFFFFFF)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(text1, style: FontStyles.regular20),
              Text(text2, style: FontStyles.regular15),
            ],
          ),
          Gap(10),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(color),
            ),
            child: SvgPicture.asset(image),
          ),
        ],
      ),
    );
  }
}
