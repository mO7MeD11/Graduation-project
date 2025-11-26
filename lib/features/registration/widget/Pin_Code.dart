import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart' show PinCodeFieldShape, PinTheme, PinCodeTextField;

class PinCode extends StatelessWidget {
  const PinCode({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: PinCodeTextField(
        appContext: context,
        enableActiveFill: true,

        length: 4,

        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 40,
          fieldWidth: 40,

          activeColor: Color(0xffffffff),
          disabledColor: Color(0xffffffff),
          inactiveColor: Color(0xffffffff),
          selectedColor: Color(0xffffffff),
          inactiveFillColor: Color(0xffffffff),
          selectedFillColor: Color(0xffffffff),
          activeFillColor: Color(0xffffffff),
          errorBorderColor: Color(0xffffffff),
        ),
      ),
    );
  }
}
