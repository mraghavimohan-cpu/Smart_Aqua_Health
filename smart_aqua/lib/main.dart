import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; 
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/user_dashboard.dart';
import 'screens/send_report_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   await Supabase.initialize(         
    url: 'https://vcgbctfbunmalvauscdt.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZjZ2JjdGZidW5tYWx2YXVzY2R0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE1NjY3OTEsImV4cCI6MjA4NzE0Mjc5MX0.A4unk1gnrYlMz_y1LlnnH-zno6msuaPq_hPSlku4Z5Q',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Water Health Monitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      // Start with Login Screen
      home: const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/dashboard': (context) => const UserDashboard(),
        '/send_report': (context) => const SendReportScreen(),
      },
    );
  }
}