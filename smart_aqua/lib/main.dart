import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/patient_details_screen.dart';
import 'screens/water_quality_screen.dart';
import 'screens/ai_prediction_screen.dart';
import 'screens/final_report_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Water Health Monitor',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/patient': (context) => PatientDetailsScreen(),
        '/water': (context) => WaterQualityScreen(),
        '/prediction': (context) => AIPredictionScreen(),
        '/report': (context) => FinalReportScreen(),
      },
    );
  }
}