import 'package:flutter/material.dart';
import 'package:ke_domain_connect/Auth/SignUp.dart' hide FadeAnimationSimple;
import 'FadedAnimation.dart';

class UserSignUp extends StatefulWidget {
  @override
  _UserSignUpState createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xAA1A1B1E),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeAnimationSimple(1.0, Text("Create your account.",
              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)),
            SizedBox(height: 30,),

            FadeAnimationSimple(1.3, Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xAA1A1B1E),
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
                    child: TextField(
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
                    child: TextField(
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
                    child: TextField(
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
                              child: Icon(Icons.remove_red_eye, color: Color(0xFF5C5F65),)),
                          hintText: "Password"
                      ),
                    ),
                  ),
                  // Confirm Password
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextField(
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
                              child: Icon(Icons.remove_red_eye, color: Color(0xFF5C5F65),)),
                          hintText: "Confirm Password"
                      ),
                    ),
                  ),
                ],
              ),
            )),
            SizedBox(height: 40,),

            FadeAnimationSimple(1.6, Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                onPressed: () {},
                color: Color(0xFFF15E33),
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Center(child: Text("Create Account",
                  style: TextStyle(color: Colors.white.withOpacity(.7), fontSize: 16),)),
              ),
            )),
            SizedBox(height: 20,),
            FadeAnimationSimple(1.8, Center(
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrarApplication()),
                  );
                },
                color: Color(0xFFF15E33),
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Center(child: Text("Create Account As A Registrar",
                  style: TextStyle(color: Colors.white.withOpacity(.7), fontSize: 16),)),
              ),
            )),
          ],
        ),
      ),
    );
  }
}