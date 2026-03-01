import 'package:flutter/material.dart';
import '../widgets/ui_components.dart';

class AIPredictionScreen extends StatefulWidget {
  const AIPredictionScreen({super.key});

  @override
  State<AIPredictionScreen> createState() => _AIPredictionScreenState();
}

class _AIPredictionScreenState extends State<AIPredictionScreen> {
  String predictionResult = "Analyzing...";
  bool isAnalyzing = true;

  @override
  void initState() {
    super.initState();
    _runPrediction();
  }

  Future<void> _runPrediction() async {
    // Simulate AI prediction delay
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      predictionResult = "Possible Waterborne Disease Detected";
      isAnalyzing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: gradientWrapper(
        child: CardWrapper(
          title: "AI Prediction",
          child: Column(
            children: [
              // Show spinner only while analyzing
              if (isAnalyzing) const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                predictionResult,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // FIX: was '../screens/final_report_screen.dart' (file path, not a route)
              buildButton("Generate Report", () {
                Navigator.pushNamed(context, '/report');
              }),
            ],
          ),
        ),
      ),
    );
  }
}
