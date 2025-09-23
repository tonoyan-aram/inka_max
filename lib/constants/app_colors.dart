import 'package:flutter/material.dart';

class AppColors {
  // Brand colors: белый, черный, оранжевый
  static const Color primary = Color(0xFFFF6B35); // Orange
  static const Color secondary = Color(0xFF000000); // Black
  static const Color background = Color(0xFFFFFFFF); // White
  static const Color surface = Color(0xFFF5F5F5); // Light gray
  static const Color onPrimary = Color(0xFFFFFFFF); // White
  static const Color onSecondary = Color(0xFFFFFFFF); // White
  static const Color onBackground = Color(0xFF000000); // Black
  static const Color onSurface = Color(0xFF000000); // Black
  
  // Additional colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // Text colors
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textDisabled = Color(0xFF999999);
  
  // Border colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderFocused = primary;
  
  // Shadow colors
  static const Color shadow = Color(0x1A000000);
  
  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFFFF8A65)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Tag colors
  static const Map<String, Color> tagColors = {
    'health': Color(0xFF4CAF50),
    'family': Color(0xFFE91E63),
    'work': Color(0xFF2196F3),
    'nature': Color(0xFF8BC34A),
    'other': Color(0xFF9C27B0),
  };
}
