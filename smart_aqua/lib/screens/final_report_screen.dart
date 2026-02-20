import 'package:flutter/material.dart';
import '../widgets/ui_components.dart';


class FinalReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: gradientWrapper(
        child: CardWrapper(
          title: "Final Water Health Report",
          child: Column(
            children: [
              Text(
                "Water Status: Unsafe",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),

              SizedBox(height: 10),

              Text("Recommended Action: Avoid Consumption"),

              SizedBox(height: 20),

              buildButton("Send SMS Alert", () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("SMS Alert Sent")));
              }),

              SizedBox(height: 10),

              buildButton("Send Voice Alert", () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Voice Call Triggered")));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
