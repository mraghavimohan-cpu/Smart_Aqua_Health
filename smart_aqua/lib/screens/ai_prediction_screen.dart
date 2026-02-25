import 'package:flutter/material.dart';
import '../screens/final_report_screen.dart';
import '../widgets/ui_components.dart';



class AIPredictionScreen extends StatefulWidget {
  @override
  _AIPredictionScreenState createState() => _AIPredictionScreenState();
}

class _AIPredictionScreenState extends State<AIPredictionScreen> {
  String predictionResult = "Analyzing...";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        predictionResult = "Possible Waterborne Disease Detected";
      });
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
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text(
                predictionResult,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),

              buildButton("Generate Report", () {
                Navigator.pushNamed(context, '../screens/final_report_screen.dart');
              }),
            ],
          ),
        ),
      ),
    );
  }
}
