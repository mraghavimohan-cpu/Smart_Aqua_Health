import 'package:flutter/material.dart';
import '../screens/ai_prediction_screen.dart';
import '../widgets/ui_components.dart';

class WaterQualityScreen extends StatelessWidget {
  final Map<String, double> waterData = {
    "pH": 6.8,
    "Turbidity": 3.2,
    "Temperature": 28.5,
    "Dissolved Oxygen": 5.6,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: gradientWrapper(
        child: CardWrapper(
          title: "Water Quality Details",
          child: Column(
            children: [
              ...waterData.entries.map((entry) {
                return ListTile(
                  title: Text(entry.key),
                  trailing: Text(entry.value.toString()),
                );
              }).toList(),

              SizedBox(height: 20),

              buildButton("Predict Disease", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AIPredictionScreen()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
