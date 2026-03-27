import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:graduationproject/core/di/service_locator.dart';
import 'package:graduationproject/core/di/service_locator.dart';
import 'package:graduationproject/features/home/presentation/views/home_screen.dart';
import 'package:graduationproject/features/home/presentation/views/map_selection_view.dart';
import 'package:graduationproject/features/home/presentation/views/submit_complaint_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // 🌍 اللغة
      locale: const Locale('ar'),

      // 🎨 Theme
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.almaraiTextTheme(),
      ),

      // 🚀 البداية
      initialRoute: '/submit-complaint',

      // 🧭 Routes
      routes: {
        '/home': (_) => const HomeScreen(),
        '/submit-complaint': (_) => const SubmitComplaintScreen(),
        '/map-selection': (_) => const EgyptMapScreen(),
      },

      // 📱 RTL
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}