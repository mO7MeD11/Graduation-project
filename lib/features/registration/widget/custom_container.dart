import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Color(0xffFFFFFF)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'اتصال ظوارئ (1213)',
            style: TextStyle(
              color: Color(0xffFF0C0C),
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          Gap(8),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xffFFD0D0),
              borderRadius: BorderRadius.circular(15),
            ),
            child: SvgPicture.asset('assets/call.svg'),
          ),
        ],
      ),
    );
  }
}
