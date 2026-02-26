import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/features/auth/Cubit/login_cubit.dart';
import 'package:graduationproject/features/auth/Cubit/regestration_Cubit.dart';
import 'package:graduationproject/features/auth/views/account_type_view.dart';
import 'package:graduationproject/features/auth/views/create_new_password.dart';
import 'package:graduationproject/features/reportsList/views/report_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => SignupCubit()),
        BlocProvider(create: (context) => LoginCubit())
      
      ],
      child: MaterialApp(
        locale: const Locale('ar'),
        home: AccountTypeView(),
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.ltr, // غير هنا من rtl إلى ltr
            child: child!,
          );
        },
      ),
    );
  }
}
