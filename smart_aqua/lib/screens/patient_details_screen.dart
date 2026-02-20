import 'package:flutter/material.dart';
import 'water_quality_screen.dart';
import '../widgets/ui_components.dart';


class PatientDetailsScreen extends StatefulWidget {
  @override
  _PatientDetailsScreenState createState() =>
      _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final locationController = TextEditingController();

  final List<String> symptomsList = [
    "Fever",
    "Vomiting",
    "Diarrhea",
    "Skin Rashes",
    "Stomach Pain"
  ];

  List<String> selectedSymptoms = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: gradientWrapper(
        child: CardWrapper(
          title: "Patient Details",
          child: Column(
            children: [

              buildTextField(nameController, "Patient Name"),
              buildTextField(ageController, "Age", isNumber: true),
              buildTextField(locationController, "Location"),

              SizedBox(height: 15),

              Text("Select Symptoms",
                  style: TextStyle(fontWeight: FontWeight.bold)),

              ...symptomsList.map((symptom) {
                return CheckboxListTile(
                  title: Text(symptom),
                  value: selectedSymptoms.contains(symptom),
                  onChanged: (value) {
                    setState(() {
                      if (value!)
                        selectedSymptoms.add(symptom);
                      else
                        selectedSymptoms.remove(symptom);
                    });
                  },
                );
              }).toList(),

              SizedBox(height: 20),

              buildButton("Next", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => WaterQualityScreen()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}