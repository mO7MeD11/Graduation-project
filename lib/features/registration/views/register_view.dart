import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graduationproject/core/style/font_style.dart';
import 'package:graduationproject/features/registration/views/register_view.dart';
import 'package:graduationproject/features/registration/widget/custom_button.dart';
import 'package:graduationproject/features/registration/widget/custom_text_form_field.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE8E8E8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Gap(100),
              Text('انشاء حساب جديد', style: FontStyles.regular24),
              Gap(20),
              Text('ادخل بياناتك للمتابعه', style: FontStyles.regular15),
              Gap(20),
              Text('رقم الجوال', style: FontStyles.regular15),
              Gap(13),
              CustomTextFormField(),
              Gap(13),
              Text('الاسم بالكامل', style: FontStyles.regular15),
              Gap(10),
              CustomTextFormField(),
              Gap(13),
              Text('رقم القومي', style: FontStyles.regular15),
              Gap(10),
              CustomTextFormField(),

              Gap(10),
              Text('كلمة المرور', style: FontStyles.regular15),
              Gap(13),
              CustomTextFormField(),
              Gap(30),
              SizedBox(
                width: double.infinity,
                child: CustomButton(text: 'دخول', onTap: () {}),
              ),
              Gap(13),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'تسجيل الدخول',
                      style: FontStyles.regular16.copyWith(
                        color: Color(0xffF59E0B),
                      ),
                    ),
                  ),
                  Gap(10),
                  Text('لديك حساب؟', style: FontStyles.regular16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
