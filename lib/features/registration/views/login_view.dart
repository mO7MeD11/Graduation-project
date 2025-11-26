import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graduationproject/core/style/font_style.dart';
import 'package:graduationproject/features/registration/views/register_view.dart';
import 'package:graduationproject/features/registration/widget/custom_button.dart';
import 'package:graduationproject/features/registration/widget/custom_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE8E8E8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Gap(100),
                Text('تسجيل الدخول', style: FontStyles.regular24),
                Gap(20),
                Text('ادخل بياناتك للمتابعه', style: FontStyles.regular15),
                Gap(20),
                Text('رقم الجوال', style: FontStyles.regular15),
                Gap(13),
                CustomTextFormField(
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "this filed is required";
                    }
                    return null;
                  },
                ),
                Gap(10),
                Text('كلمة المرور', style: FontStyles.regular15),
                Gap(13),
                CustomTextFormField(
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "this filed is required";
                    }
                    return null;
                  },
                ),
                Gap(30),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'دخول',
                    onTap: () {
                      if (formKey.currentState!.validate()) {}
                    },
                  ),
                ),
                Gap(13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterView(),
                          ),
                        );
                      },
                      child: Text(
                        'انشا حساب جديد',
                        style: FontStyles.regular16.copyWith(
                          color: Color(0xffF59E0B),
                        ),
                      ),
                    ),
                    Gap(10),
                    Text('ليس لديك حساب ؟', style: FontStyles.regular16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
