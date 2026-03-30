// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/employer/employer_dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EmployerDashboard(),
    );
  }
}