import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:graduationproject/core/style/font_style.dart';

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.text1,
    required this.text2,
    required this.image,
    required this.color,
  });
  final String text1;
  final String text2;
  final String image;
  final int color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Color(0xffFFFFFF)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(text1, style: FontStyles.regular20),
              Text(text2, style: FontStyles.regular15),
            ],
          ),
          Gap(10),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(color),
            ),
            child: SvgPicture.asset(image),
          ),
        ],
      ),
    );
  }
}
