import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/home/home_controller.dart';
import 'package:untitled/screens/home/home_view.dart';
import 'theme/app_theme.dart'; // import your theme file

void main() {
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Tracker',
      theme: AppTheme.lightTheme,     // Light mode
      darkTheme: AppTheme.darkTheme,  // Dark mode
      themeMode: ThemeMode.system,    // Auto switch (system setting)
      home: const HomeView(),
    );
  }
}
