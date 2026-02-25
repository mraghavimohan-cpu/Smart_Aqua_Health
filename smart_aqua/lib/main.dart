import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/patient_details_screen.dart';
import 'screens/water_quality_screen.dart';
import 'screens/ai_prediction_screen.dart';
import 'screens/final_report_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Water Health Monitor',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',

      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/patient': (context) => PatientDetailsScreen(),
        '/water': (context) => WaterQualityScreen(),
        '/report': (context) => FinalReportScreen(),
      },

      onGenerateRoute: (settings) {
        if (settings.name == '/prediction') {
          final waterData =
              settings.arguments as Map<String, double>;

          return MaterialPageRoute(
            builder: (context) =>
                AiPredictionScreen(waterData: waterData),
          );
        }
        return null;
      },
    );
  }
}