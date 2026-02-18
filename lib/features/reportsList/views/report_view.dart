import 'package:flutter/material.dart';
import 'package:graduationproject/features/reportsList/widget/custom_report_container.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 100, right: 30, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'قائمة بلاغاتي',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
             
              CustomReportContainer(
                name: 'أ ب ج ١٢٣٤',
                details:
                    'السائق يطلب أجرة أعلى من المقلسائق يطلب أجرة أعلى من المقر',
                date: '١٥/١٠/٢٠٢٥',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
