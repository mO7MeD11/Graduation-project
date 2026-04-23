import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:graduationproject3/core/style/font_style.dart';
import 'package:graduationproject3/features/auth/Cubit/auth_state.dart';
import 'package:graduationproject3/features/auth/Cubit/regestration_Cubit.dart';
import 'package:graduationproject3/features/auth/widget/Pin_Code.dart';
import 'package:graduationproject3/features/auth/widget/custom_button.dart';

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
      BlocProvider.of<SignupCubit>(context).sendOtp(phone: widget.phone);
    });
  }

  String code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE6E6E6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(150),
              // تعديل مسار الصورة
              Image.asset('assets/images/rased.png'),
              Text('التحقق من الرقم', style: FontStyles.regular24),
              const Gap(10),
              Text(
                'تم ارسال رمز التحقق إلى ${widget.phone}',
                style: FontStyles.regular15,
                textAlign: TextAlign.center,
              ),
              const Gap(30),
              PinCode(
                onChanged: (v) {
                  code = v;
                },
              ),
              const Gap(30),
              BlocListener<SignupCubit, AuthState>(
                listener: (context, state) {
                  if (state is VerifyOtpLoading) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Row(
                          children: [
                            Text('جاري التحميل... '),
                            CupertinoActivityIndicator(color: Colors.white),
                          ],
                        ),
                      ),
                    );
                  } else if (state is VerifyOtpSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم التحقق بنجاح')),
                    );
                  } else if (state is VerifyOtpError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                child: CustomButton(
                  text: 'تأكيد',
                  onTap: () {
                    if (code.length != 4) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('من فضلك ادخل الكود كاملاً')),
                      );
                      return;
                    }
          
                    BlocProvider.of<SignupCubit>(
                      context,
                    ).verifyOtp(phone: widget.phone, code: code);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
