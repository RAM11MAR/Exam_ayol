import 'package:exam1/presentation/home/pages/main_dashboard.dart';
import 'package:flutter/material.dart';
import 'core/theme/theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam Ayol',
      theme: appTheme,
      home: HomePage(),
    );
  }
}
