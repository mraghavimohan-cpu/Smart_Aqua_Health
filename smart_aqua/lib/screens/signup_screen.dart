import 'package:flutter/material.dart';
import '../utils/validators.dart';
import '../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool acceptTerms = false;
  double passwordStrength = 0;

  void checkPasswordStrength(String password) {
    double strength = 0;

    if (password.length >= 8) strength += 0.2;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.2;
    if (RegExp(r'[a-z]').hasMatch(password)) strength += 0.2;
    if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.2;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength += 0.2;

    setState(() {
      passwordStrength = strength;
    });
  }

  Color getStrengthColor() {
    if (passwordStrength <= 0.4) return Colors.red;
    if (passwordStrength <= 0.8) return Colors.orange;
    return Colors.green;
  }

  String getStrengthText() {
    if (passwordStrength <= 0.4) return "Weak";
    if (passwordStrength <= 0.8) return "Medium";
    return "Strong";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4FC3F7), // Sky Blue
              Color(0xFF0D47A1), // Dark Blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Image.asset('lib/assets/logo.png', height: 90),

                        SizedBox(height: 15),

                        Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D47A1),
                          ),
                        ),

                        SizedBox(height: 20),

                        /// NAME
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: "Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? "Name required" : null,
                        ),

                        SizedBox(height: 15),

                        /// LOCATION
                        TextFormField(
                          controller: locationController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            labelText: "Location",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),

                        SizedBox(height: 15),

                        /// PHONE
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            labelText: "Phone Number",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: Validators.validatePhone,
                        ),

                        SizedBox(height: 15),

                        /// PASSWORD
                        TextFormField(
                          controller: passwordController,
                          obscureText: !isPasswordVisible,
                          onChanged: checkPasswordStrength,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (!acceptTerms) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Accept Terms & Conditions")),
                                    );
                                    return;
                                  }
                                  bool success = AuthService.register(
                                    nameController.text,
                                    phoneController.text,
                                    passwordController.text,
                                  );
                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Registration Successful")),
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("User already exists")),
                                    );
                                  }
                                }
                              }
                            ),
                          ),
                          validator: Validators.validatePassword,
                        ),

                        SizedBox(height: 10),

                        /// PASSWORD STRENGTH BAR
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          height: 8,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: passwordStrength,
                            child: Container(
                              decoration: BoxDecoration(
                                color: getStrengthColor(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          "Strength: ${getStrengthText()}",
                          style: TextStyle(
                            color: getStrengthColor(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 15),

                        /// CONFIRM PASSWORD
                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            labelText: "Confirm Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value != passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 15),

                        /// TERMS CHECKBOX
                        Row(
                          children: [
                            Checkbox(
                              value: acceptTerms,
                              onChanged: (value) {
                                setState(() {
                                  acceptTerms = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: Text("I accept Terms & Conditions"),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        /// REGISTER BUTTON
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF4FC3F7), Color(0xFF0D47A1)],
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (!acceptTerms) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Please accept Terms & Conditions",
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Account Created Successfully",
                                    ),
                                  ),
                                );

                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
