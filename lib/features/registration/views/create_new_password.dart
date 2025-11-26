import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graduationproject/core/style/font_style.dart';
import 'package:graduationproject/features/registration/widget/custom_button.dart';
import 'package:graduationproject/features/registration/widget/custom_text_form_field.dart';

class CreateNewPassword extends StatelessWidget {
  const CreateNewPassword({super.key});

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
              Gap(200),
              Text('إنشاء كلمة مرور جديدة', style: FontStyles.regular24),
              Gap(20),
              Text(
                'لاكمال تسجيل جسابك يرجي تعيين كلمة مرور قويه',
                style: FontStyles.regular15,
              ),
              Gap(20),
              Text('كلمة المرور الجديده', style: FontStyles.regular15),
              Gap(13),
              CustomTextFormField(validator: (v) {}),
              Gap(10),
              Text('تاكيد كلمة المرور', style: FontStyles.regular15),
              Gap(13),
              CustomTextFormField(validator: (v) {}),
              Gap(30),
              SizedBox(
                width: double.infinity,
                child: CustomButton(text: 'دخول', onTap: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
