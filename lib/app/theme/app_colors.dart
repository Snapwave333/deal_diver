import 'package:flutter/material.dart';

class AppColors {
  // --- Core Palette ---
  static const Color primary = Color(0xFF6B4BFF); // A vibrant, electric blue
  static const Color secondary = Color(0xFFC33D8B); // A deep, neon magenta

  // --- Dark Theme Specific ---
  static const Color darkBackground = Color(0xFF0A0A14); // Deep, dark navy
  static const Color darkSurface = Color(0xFF161625);   // Slightly lighter surface
  static const Color darkAccent = Color(0x336B4BFF);     // Glow effect for primary

  // --- Light Theme Specific ---
  static const Color lightBackground = Color(0xFFF5F5FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightText = Colors.black87;

  // --- Common Colors ---
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color error = Color(0xFFFF4949);
}
