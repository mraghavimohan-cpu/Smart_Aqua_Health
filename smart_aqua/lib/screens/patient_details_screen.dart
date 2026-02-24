import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'water_quality_screen.dart';

class PatientDetailsScreen extends StatefulWidget {
  @override
  _PatientDetailsScreenState createState() =>
      _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();

  String waterUse = "Drinking";

  final List<String> symptomsList = [

    // General symptoms
    "Fever",
    "Nausea",
    "Fatigue",
    "Diarrhea",
    "Vomiting",

    // Skin related
    "Skin Rash",

    // Water-related bone disease (Fluorosis indicators)
    "Joint Pain",
    "Stiffness in Joints",
    "Bone Pain",
    "Back Pain",
    "Difficulty Walking",
    "Dental Stains",
  ];

  List<String> selectedSymptoms = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black),
        title: Text("Health Assessment",
            style: TextStyle(color: Colors.black)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                "STEP 1/2",
                style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              LinearProgressIndicator(
                value: 0.5,
                backgroundColor: Colors.grey[300],
                color: Colors.teal,
              ),

              SizedBox(height: 25),

              Text(
                "1. Patient Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),

              buildField(
                controller: nameController,
                hint: "Full Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter name";
                  }
                  return null;
                },
              ),

              SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: buildField(
                      controller: ageController,
                      hint: "Age",
                      isNumber: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter age";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: waterUse,
                      decoration: roundedDecoration("Water Use"),
                      items: ["Drinking", "Cooking", "Bathing"]
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          waterUse = val!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15),

              buildField(
                controller: phoneController,
                hint: "Phone Number",
                isNumber: true,
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter phone number";
                  }
                  if (value.length != 10) {
                    return "Phone number must be 10 digits";
                  }
                  return null;
                },
              ),

              SizedBox(height: 15),

              buildField(
                controller: locationController,
                hint: "Location",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter location";
                  }
                  return null;
                },
              ),

              SizedBox(height: 25),

              Text(
                "Symptoms (Multi-select)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 15),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: symptomsList.map((symptom) {
                  final isSelected =
                      selectedSymptoms.contains(symptom);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected)
                          selectedSymptoms.remove(symptom);
                        else
                          selectedSymptoms.add(symptom);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.teal
                            : Colors.white,
                        borderRadius:
                            BorderRadius.circular(25),
                        border: Border.all(
                            color: Colors.teal),
                      ),
                      child: Text(
                        symptom,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              WaterQualityScreen(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildField({
    required TextEditingController controller,
    required String hint,
    bool isNumber = false,
    int? maxLength,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType:
          isNumber ? TextInputType.number : TextInputType.text,
      maxLength: maxLength,
      inputFormatters: isNumber
          ? [
              FilteringTextInputFormatter.digitsOnly,
              if (maxLength != null)
                LengthLimitingTextInputFormatter(maxLength),
            ]
          : [],
      validator: validator,
      decoration: roundedDecoration(hint).copyWith(
        counterText: "",
      ),
    );
  }

  InputDecoration roundedDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    );
  }
}