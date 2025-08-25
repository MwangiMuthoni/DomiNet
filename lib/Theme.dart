import 'package:flutter/material.dart';

abstract class CustomTheme {
  var grey_color = const Color(0xFFE0E0E2);

  static final ButtonStyle blueButton = TextButton.styleFrom(
    padding: const EdgeInsets.all(15.0),
    backgroundColor: const Color(0xFF294E98),
    foregroundColor: Colors.white,
    minimumSize: const Size.fromHeight(30),
    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  );
  static final ButtonStyle blueButtonSmall = TextButton.styleFrom(
    padding: const EdgeInsets.all(10.0),
    backgroundColor: const Color(0xFF294E98),
    foregroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  );

  static final ButtonStyle pinkButton = TextButton.styleFrom(
    padding: const EdgeInsets.all(15.0),
    backgroundColor: const Color(0xFFFA4377),
    foregroundColor: Colors.white,
    minimumSize: const Size.fromHeight(30),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  );

  static final ButtonStyle pinkButtonSmall = TextButton.styleFrom(
    padding: const EdgeInsets.all(10),
    backgroundColor: const Color(0xFFFA4377),
    foregroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  );

  static final ButtonStyle clearButton = TextButton.styleFrom(
    minimumSize: const Size.fromHeight(16),
    foregroundColor: const Color(0xFF294E98),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );

  static final ButtonStyle outlineButton = TextButton.styleFrom(
    padding: const EdgeInsets.all(10.0),
    foregroundColor: Colors.black,
    minimumSize: const Size.fromHeight(30),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
      side: const BorderSide(
        color: Colors.grey, // Set the color of the border
        width: 1.0, // Set the width of the border to 1px
      ),
    ),
  );

  static const TextStyle headingStyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  static const TextStyle drawerStyle =
  TextStyle(fontSize: 22, fontWeight: FontWeight.w500);
  static const TextStyle titleStyle =
  TextStyle(fontSize: 22, fontWeight: FontWeight.w700);
  static const TextStyle titleStyleLight =
  TextStyle(fontSize: 22, fontWeight: FontWeight.w400);
  static const TextStyle bodyStyle =
  TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
  static const TextStyle bodyStyleSM =
  TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  static const TextStyle bodyStyleSMBold =
  TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  static const TextStyle bodyStyleError =
  TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.red);
  static const TextStyle bodyStyleXL =
  TextStyle(fontSize: 32, fontWeight: FontWeight.w600);
  static const TextStyle bodyStyleBold =
  TextStyle(fontSize: 18, fontWeight: FontWeight.w700);
  static const TextStyle bodyStylegreen = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Color(0xFF3EAF2B),
  );
  static const TextStyle bodyStyleRedBold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.red,
  );
  static const TextStyle bodyStyleLight =
  TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white);
  static const TextStyle itemStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: Colors.black,
  );
  static const TextStyle itemStyleLight = TextStyle(
    fontSize: 16,
    color: Color.fromRGBO(250, 67, 117, 1),
  );
  static final InputDecorationTheme inputTheme = InputDecorationTheme(
    fillColor: const Color(0xFFE0E0E2),
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    contentPadding:
    const EdgeInsets.fromLTRB(20, 16, 20, 8), // Adjusted padding
    labelStyle: const TextStyle(
      fontSize: 18,
    ),
    floatingLabelStyle: const TextStyle(
      fontSize: 20, // Adjusted font size
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(
          width: 1, color: Colors.black12), // Adjusted border width
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(
          width: 1,
          color: Color.fromRGBO(250, 67, 117, 1)), // Adjusted border color
    ),
  );
}
