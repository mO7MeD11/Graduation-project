import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graduationproject/features/details/widget/custom_card.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE8E8E8),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Gap(100),
              Text(
                ' تفاصيل بلاغ C001',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Almarai',
                ),
              ),
              Gap(80),
              CustomCard(
                reportNumber: 'C801',
                carNumber: ' أ ب ج ١٢٣٤',
                desc: 'السائق يطلب أجرة أعلى من المقررة',
                location: 'شاع ترعه، المنصوره',
                date: '١٥/١٠/٢٠٢٥',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
