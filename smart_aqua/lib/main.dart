import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/patient_details_screen.dart';
import 'screens/water_quality_screen.dart';
import 'screens/ai_prediction_screen.dart';
import 'screens/final_report_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        scaffoldBackgroundColor: const Color(0xFFF3F5F7),
      ),

      initialRoute: '/',

      // Static routes
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/patient': (context) => PatientDetailsScreen(),
        '/water': (context) => WaterQualityScreen(),
      },

      // Dynamic routes
      onGenerateRoute: (settings) {
        if (settings.name == '/prediction') {
          final waterData =
              settings.arguments as Map<String, double>;

          return MaterialPageRoute(
            builder: (_) =>
                AiPredictionScreen(waterData: waterData),
          );
        }

        if (settings.name == '/report') {
          final waterData =
              settings.arguments as Map<String, double>;

          return MaterialPageRoute(
            builder: (_) =>
                FinalReportScreen(waterData: waterData),
          );
        }

        return null;
      },
    );
  }
}