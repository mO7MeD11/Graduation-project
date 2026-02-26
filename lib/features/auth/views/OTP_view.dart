import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:graduationproject/core/style/font_style.dart';
import 'package:graduationproject/features/auth/Cubit/regestration_Cubit.dart';
import 'package:graduationproject/features/auth/widget/Pin_Code.dart';
import 'package:graduationproject/features/auth/widget/custom_button.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key, required this.phone});
  final String phone;

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  
  @override
  void initState() {
     
    super.initState();
    
    
      
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SignupCubit>(
        context,
      ).sendOtp(phone: widget.phone);  
    });
  }
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
              '${maskedPhone(widget.phone)}تم ارسال الرمزالتحقيق الي',
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

String maskedPhone(String phone) {
  if (phone.length <= 3) return phone;

  final last3 = phone.substring(phone.length - 3);
  final first3 = phone.substring(0, 3);
  final starsCount = phone.length - 6;
  final stars = '*' * starsCount;

  return '$first3 $stars $last3';
}
