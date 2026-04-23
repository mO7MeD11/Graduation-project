import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graduationproject3/core/style/font_style.dart';
import 'package:graduationproject3/features/auth/views/login_view.dart';
import 'package:graduationproject3/features/auth/widget/custom_container.dart';
import 'package:graduationproject3/features/auth/widget/roale_card.dart';

class AccountTypeView extends StatefulWidget {
  const AccountTypeView({super.key});

  @override
  State<AccountTypeView> createState() => _AccountTypeViewState();
}

class _AccountTypeViewState extends State<AccountTypeView> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8E8E8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(100),
            // تعديل مسار الصورة
            Image.asset('assets/images/rased.png'),
            Text('مرحباً في راصد', style: FontStyles.regular24),
            Text('اختر نوع الحساب', style: FontStyles.regular15),
            const Gap(70),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
              child: const RoleCard(
                image: 'assets/images/person.svg', // تعديل المسار
                text1: 'راكب',
                text2: 'للابلاغ ومتابعة الشكاوي',
                color: 0xff778B94,
              ),
            ),
            const Gap(18),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
              child: const RoleCard(
                image: 'assets/images/car.svg', // تعديل المسار
                text1: 'سواق',
                text2: 'لمتابعة الحالة والامتثال',
                color: 0xffFFF4A0,
              ),
            ),
            const Gap(35),
            InkWell(
              onTap: () {
                setState(() {
                  isActive = !isActive;
                });
              },
              child: const CustomContainer(),
            ),
            const Gap(35),
            SizedBox(
              height: 90,
              child: isActive
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomBox(
                          color1: Color(0xff26D829),
                          text1: '1012',
                          color2: Colors.black,
                          text2: '#',
                        ),
                        CustomBox(
                          color1: Colors.black,
                          text1: '1012',
                          color2: Colors.black,
                          text2: 'المرور',
                        ),
                        CustomBox(
                          color1: Color(0xffFD2121),
                          text1: '1012',
                          color2: Colors.black,
                          text2: 'الطوارئ',
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBox extends StatelessWidget {
  const CustomBox({
    super.key,
    required this.color1,
    required this.text1,
    required this.color2,
    required this.text2,
  });
  final Color color1;
  final String text1;
  final Color color2;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xffFFFFFF),
          ),
          child: Column(
            children: [
              Text(text1, style: TextStyle(color: color1)),
              Text(text2, style: TextStyle(color: color2)),
            ],
          ),
        ),
      ),
    );
  }
}
