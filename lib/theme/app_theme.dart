// الكود الكامل هنا 
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Colors.blue,
        secondary: Colors.green,
      ),
      useMaterial3: true,
    );
  }
}
