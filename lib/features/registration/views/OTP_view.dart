import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graduationproject/core/style/font_style.dart';
import 'package:graduationproject/features/registration/widget/Pin_Code.dart';
import 'package:graduationproject/features/registration/widget/custom_button.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE6E6E6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Gap(200),
            Image.asset('assets/rased.png'),
            Text('التحقيق من الرقم', style: FontStyles.regular24),
            Gap(10),
            Text(
              'تم ارسال الرمزالتحقيق الي843 **** 010',
              style: FontStyles.regular15,
            ),
            Gap(30),
            PinCode(),
            Gap(30),
            CustomButton(text: 'تاكيد', onTap: () {}),
          ],
        ),
      ),
    );
  }
}