import 'package:flutter/material.dart';
import 'package:graduationproject/features/registration/views/account_type_view.dart';
import 'package:graduationproject/features/registration/views/create_new_password.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ar'),
      home: AccountTypeView(),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr, // غير هنا من rtl إلى ltr
          child: child!,
        );
      },
    );
  }
}
