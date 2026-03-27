import 'package:flutter/material.dart';

class CustomReportContainer extends StatelessWidget {
  const CustomReportContainer({
    super.key,
    required this.name,
    required this.details,
    required this.date,
  });

  final String name, details, date;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18),
      decoration: ShapeDecoration(
        color: Color(0xffD9D9D9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Color(0xff002349),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Almarai',
                  ),
                ),
                Text(
                  details,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Almarai',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Almarai',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),

          Container(
            width: 15,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }
}
