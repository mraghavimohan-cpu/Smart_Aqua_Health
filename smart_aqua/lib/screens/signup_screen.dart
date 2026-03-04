import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isLoading = false;

  @override
  void dispose() {
    firstNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF3F4),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// HEADER
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Create Your Account",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),

                      /// GRADIENT HEADER BOX
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF0F6B6B),
                              Color(0xFF1CA7A6),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.water_drop,
                                color: Colors.white, size: 40),
                            SizedBox(height: 8),
                            Text(
                              "AquaSense IoT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),

                      SizedBox(height: 25),

                      Text("First Name"),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: " name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Required" : null,
                      ),

                      SizedBox(height: 15),

                      /// EMAIL
                      Text("Email Address"),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || !value.contains('@')) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 15),

                      /// PASSWORD
                      Text("Password"),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Password",
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
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length < 8) {
                            return "Minimum 8 characters required";
                          }
                          if (!RegExp(r'[A-Z]').hasMatch(value)) {
                            return "Add uppercase letter";
                          }
                          if (!RegExp(r'[0-9]').hasMatch(value)) {
                            return "Add number";
                          }
                          if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                              .hasMatch(value)) {
                            return "Add special character";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 10),

                      /// SECURITY BOX
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "SECURITY REQUIREMENTS",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.teal),
                            ),
                            SizedBox(height: 8),
                            Text("• 8+ characters"),
                            Text("• At least 1 special character"),
                            Text("• Uppercase & lowercase letters"),
                            Text("• Include at least one number"),
                          ],
                        ),
                      ),

                      SizedBox(height: 15),

                      /// CONFIRM PASSWORD
                      Text("Confirm Password"),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_reset),
                          hintText: "Confirm Password",
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

                      SizedBox(height: 25),

                      /// CREATE BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0F6B6B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => isLoading = true);

                                    final result = await AuthService.register(
                                      firstName:
                                          firstNameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );

                                    if (!context.mounted) return;
                                    setState(() => isLoading = false);

                                    if (result['success'] == true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Account created successfully. Please login."),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      // Navigate to login and clear stack
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/login',
                                        (route) => false,
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(result['error'] ??
                                              "Registration failed. Please check details or try logging in."),
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      );
                                    }
                                  }
                                },
                          child: isLoading
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "Create Account →",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),

                      SizedBox(height: 15),

                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Already have an account? Log in",
                            style: TextStyle(
                                color: Color(0xFF0F6B6B),
                                fontWeight: FontWeight.bold),
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
    );
  }
}
