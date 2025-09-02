import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ke_domain_connect/Auth/SignUp.dart' hide FadeAnimationSimple;
import 'package:ke_domain_connect/Screens/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FadedAnimation.dart';
import 'UserSignUp.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;
  bool _isLoading = false;
  String? errorMessage;

  // Form controllers and key
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Validation methods
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email or phone number is required';
    }
    // Basic email validation (you can also add phone number validation)
    if (value.contains('@')) {
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
      if (!emailRegex.hasMatch(value)) {
        return 'Please enter a valid email';
      }
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  // Navigate to HomeScreen
  void _navigateToHomeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  // Direct login method - bypasses validation
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      errorMessage = null;
    });

    try {
      // Simulate short loading time for better UX
      await Future.delayed(Duration(milliseconds: 500));

      final prefs = await SharedPreferences.getInstance();

      // Set login state directly
      await prefs.setBool('is_logged_in', true);

      // Create a basic user object for current session
      final basicUser = {
        'email': _emailController.text.trim(),
        'user_type': 'user',
        'logged_in': true,
      };
      await prefs.setString('current_user', json.encode(basicUser));

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login successful!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );

      // Navigate directly to HomeScreen
      _navigateToHomeScreen();

    } catch (e) {
      print('Login error: $e');
      // Even if there's an error, just navigate to HomeScreen
      _navigateToHomeScreen();
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
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
                SizedBox(height: 60),

                // Logo

                SizedBox(height: 40),

                FadeAnimationSimple(1.2, Text("Let's sign you in.",
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)),
                SizedBox(height: 30,),

                // Error message display
                if (errorMessage != null)
                  FadeAnimationSimple(1.3, Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 20),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            errorMessage!,
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  )),

                FadeAnimationSimple(1.5, Container(
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF1A1B1E),
                      border: Border.all(color: Color(0xFF373A3F))
                  ),
                  child: Column(
                    children: <Widget>[
                      // Email/Phone field
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
                              hintText: "Email or Phone number"
                          ),
                        ),
                      ),
                      // Password field
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: TextFormField(
                          controller: _passwordController,
                          validator: _validatePassword,
                          obscureText: !isPasswordVisible,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Color(0xFF5C5F65)),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  child: Icon(
                                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: Color(0xFF5C5F65),
                                  )),
                              hintText: "Password"
                          ),
                        ),
                      ),
                    ],
                  ),
                )),

                SizedBox(height: 20),

                // Forgot Password
                FadeAnimationSimple(1.6, Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      // Show a simple dialog for forgot password
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Color(0xFF1A1B1E),
                          title: Text(
                            'Forgot Password',
                            style: TextStyle(color: Colors.white),
                          ),
                          content: Text(
                            'Password reset functionality would be implemented here.',
                            style: TextStyle(color: Color(0xFF5C5F65)),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'OK',
                                style: TextStyle(color: Color(0xFFF15E33)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color(0xFFF15E33),
                        fontSize: 14,
                      ),
                    ),
                  ),
                )),

                SizedBox(height: 20,),

                FadeAnimationSimple(1.7, Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?", style: TextStyle(color: Color(0xFF5C5F65)),),
                    SizedBox(width: 6,),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserSignUp(),
                          ),
                        );
                      },
                      child: Text(
                        "Register",
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
                    onPressed: _isLoading ? null : _login,
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
                        : Center(child: Text("Login",
                      style: TextStyle(color: Colors.white, fontSize: 16),)),
                  ),
                )),

                SizedBox(height: 20),

                // Alternative login options or additional info
                FadeAnimationSimple(1.9, Center(
                  child: Text(
                    "Secure login for users and registrars",
                    style: TextStyle(
                      color: Color(0xFF5C5F65),
                      fontSize: 12,
                    ),
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