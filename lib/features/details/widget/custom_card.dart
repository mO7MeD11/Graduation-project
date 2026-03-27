import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.reportNumber,
    required this.carNumber,
    required this.desc,
    required this.location,
    required this.date,
  });

  final String reportNumber, carNumber, desc, location, date;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffFAFAFA),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text('تم الحل'),
                ),
                Spacer(),
                Text('   $reportNumber :بلاغ رقم '),
              ],
            ),
            Text('$reportNumber :رقم المركبه'),
            Text('$desc : الوصف'),
            Text('$location : تم الحل'),
            Text('$date : التاريخ'),
          ],
        ),
      ),
    );
  }
}
