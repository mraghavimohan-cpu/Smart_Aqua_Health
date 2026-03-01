import 'package:flutter/material.dart';
import '../widgets/ui_components.dart';

class FinalReportScreen extends StatelessWidget {
  const FinalReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: gradientWrapper(
        child: CardWrapper(
          title: "Final Water Health Report",
          child: Column(
            children: [
              const Text(
                "Water Status: Unsafe",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
              const Text("Recommended Action: Avoid Consumption"),
              const SizedBox(height: 20),
              buildButton("Send SMS Alert", () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("SMS Alert Sent")),
                );
              }),
              const SizedBox(height: 10),
              buildButton("Send Voice Alert", () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Voice Call Triggered")),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
