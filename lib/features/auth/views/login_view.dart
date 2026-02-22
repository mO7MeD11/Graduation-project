import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:graduationproject/core/style/font_style.dart';
import 'package:graduationproject/features/auth/Cubit/auth_state.dart';
import 'package:graduationproject/features/auth/Cubit/login_cubit.dart';
import 'package:graduationproject/features/auth/views/register_view.dart';
import 'package:graduationproject/features/auth/widget/custom_button.dart';
import 'package:graduationproject/features/auth/widget/custom_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                  textController: phoneController,
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
                BlocListener<LoginCubit, AuthState>(
                  listener: (context, state) {
                    if (state is ErrorState) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    } else if (state is SuccessState) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('success')));

                     
                    } else if (state is LoadingState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Text('loading'),
                              CupertinoActivityIndicator(color: Colors.white),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'دخول',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          
                            BlocProvider.of<LoginCubit>(context).login(
                            phone: phoneController.text.trim(),
                            password: passwordController.text.trim(),
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
