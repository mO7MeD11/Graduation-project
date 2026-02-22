import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:graduationproject/core/style/font_style.dart';
import 'package:graduationproject/features/auth/Cubit/regestration_Cubit.dart';
import 'package:graduationproject/features/auth/Cubit/auth_state.dart';
import 'package:graduationproject/features/auth/views/register_view.dart';
import 'package:graduationproject/features/auth/widget/custom_button.dart';
import 'package:graduationproject/features/auth/widget/custom_text_form_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ssnController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE8E8E8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                CustomTextFormField(
                  textController: phoneController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "this filed is required";
                    }
                    return null;
                  },
                ),
                Gap(13),
                Text('الاسم بالكامل', style: FontStyles.regular15),
                Gap(10),
                CustomTextFormField(
                  textController: nameController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "this filed is required";
                    }
                    return null;
                  },
                ),
                Gap(13),
                Text('رقم القومي', style: FontStyles.regular15),
                Gap(10),
                CustomTextFormField(
                  textController: ssnController,
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
                  textController: passwordController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "this filed is required";
                    }
                    return null;
                  },
                ),
                Gap(30),
                BlocListener<SignupCubit, AuthState>(
                  listener: (context, state) {
                    if (state is LoadingState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Text('loading '),
                              CupertinoActivityIndicator(color: Colors.white),
                            ],
                          ),
                        ),
                      );
                    } else if (state is SuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Success! login now ')),
                      );
                    } else if (state is ErrorState) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'دخول',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<SignupCubit>(context).signup(
                            name: nameController.text,

                            password: passwordController.text,
                            phone: phoneController.text,
                            confirmPassword: passwordController.text,
                            ssn: int.tryParse(ssnController.text) ?? 1213,
                          );
                        }
                      },
                    ),
                  ),
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
      ),
    );
  }
}
