import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ke_domain_connect/Auth/SignUp.dart' hide FadeAnimationSimple;
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/HomeScreen.dart';
import 'FadedAnimation.dart';

class UserSignUp extends StatefulWidget {
  @override
  _UserSignUpState createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool termsAccepted = false;
  String errorMessage = '';

  // Text controllers for form fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up controllers
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Validation methods
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  // Frontend-only registration method
  Future<void> _registration() async {
    // Clear any previous error messages
    setState(() {
      errorMessage = '';
    });

    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Check if terms are accepted
    if (!termsAccepted) {
      setState(() {
        errorMessage = 'Please accept the terms and conditions';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate a delay for registration process
      await Future.delayed(Duration(seconds: 2));

      // Create user data object
      Map<String, dynamic> userData = {
        'fullName': _fullNameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'registrationDate': DateTime.now().toIso8601String(),
      };

      // Save user data locally using SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', json.encode(userData));
      await prefs.setBool('is_logged_in', true);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account created successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to next screen or pop back
      Navigator.pop(context);

    } catch (e) {
      setState(() {
        errorMessage = 'Registration failed. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1B1E),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 60), // Add some top spacing

                FadeAnimationSimple(1.0, Text("Create your account.",
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)),
                SizedBox(height: 30,),

                // Error message display
                if (errorMessage.isNotEmpty)
                  FadeAnimationSimple(1.1, Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                    ),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  )),

                FadeAnimationSimple(1.3, Container(
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF1A1B1E),
                      border: Border.all(color: Color(0xFF373A3F))
                  ),
                  child: Column(
                    children: <Widget>[
                      // Full Name
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xFF373A3F)))
                        ),
                        child: TextFormField(
                          controller: _fullNameController,
                          validator: _validateFullName,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Color(0xFF5C5F65)),
                              hintText: "Full Name"
                          ),
                        ),
                      ),
                      // Email
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xFF373A3F)))
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          validator: _validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Color(0xFF5C5F65)),
                              hintText: "Email Address"
                          ),
                        ),
                      ),
                      // Password
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xFF373A3F)))
                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          validator: _validatePassword,
                          obscureText: !_isPasswordVisible,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Color(0xFF5C5F65)),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                  child: Icon(
                                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: Color(0xFF5C5F65),
                                  )),
                              hintText: "Password"
                          ),
                        ),
                      ),
                      // Confirm Password
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          validator: _validateConfirmPassword,
                          obscureText: !_isConfirmPasswordVisible,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Color(0xFF5C5F65)),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                    });
                                  },
                                  child: Icon(
                                    _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: Color(0xFF5C5F65),
                                  )),
                              hintText: "Confirm Password"
                          ),
                        ),
                      ),
                    ],
                  ),
                )),

                SizedBox(height: 20),

                // Terms and Conditions Checkbox
                FadeAnimationSimple(1.4, Row(
                  children: [
                    Checkbox(
                      value: termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          termsAccepted = value ?? false;
                        });
                      },
                      activeColor: Color(0xFFF15E33),
                      checkColor: Colors.white,
                    ),
                    Expanded(
                      child: Text(
                        "I accept the terms and conditions of Kenic Ltd.",
                        style: TextStyle(color: Color(0xFF5C5F65), fontSize: 14),
                      ),
                    ),
                  ],
                )),

                SizedBox(height: 20,),

                FadeAnimationSimple(1.6, Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Already have an account?", style: TextStyle(color: Color(0xFF5C5F65)),),
                    SizedBox(width: 6,),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: Color(0xFFF15E33),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )),

                SizedBox(height: 20,),

                FadeAnimationSimple(1.8, Center(
                  child: MaterialButton(
                    onPressed: _isLoading ? null : _registration,
                    color: Color(0xFFF15E33),
                    disabledColor: Color(0xFFF15E33).withOpacity(0.5),
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: _isLoading
                        ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                        : Center(child: Text("Create Account",
                      style: TextStyle(color: Colors.white, fontSize: 16),)),
                  ),
                )),
                SizedBox(height: 20,),
                FadeAnimationSimple(1.9, Center(
                  child: MaterialButton(
                    onPressed: _isLoading ? null : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistrarApplication()),
                      );
                    },
                    color: Colors.transparent,
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Color(0xFFF15E33))
                    ),
                    child: Center(child: Text("Create Account As A Registrar",
                      style: TextStyle(color: Color(0xFFF15E33), fontSize: 16),)),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}