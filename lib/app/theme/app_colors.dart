import 'package:flutter/material.dart';

class AppColors {
  // --- Core Palette from coolors.co/e6eed6-dde2c6-bbc5aa-a72608-090c02 ---
  static const Color primary = Color(0xFFA72608); // Burnt Orange
  static const Color secondary = Color(0xFFBBC5AA); // Muted Green-Gray

  // --- Light Theme ---
  static const Color lightBackground = Color(0xFFE6EED6); // Very light greenish-gray
  static const Color lightSurface = Color(0xFFDDE2C6); // Light greenish-gray
  static const Color lightText = Color(0xFF090C02); // Very dark desaturated green

  // --- Dark Theme ---
  static const Color darkBackground = Color(0xFF090C02); // Very dark desaturated green
  static const Color darkSurface = Color(0xFF1A1F12);   // A slightly lighter version of the dark background
  static const Color darkText = Color(0xFFE6EED6); // Very light greenish-gray for text on dark backgrounds.
  static const Color darkAccent = Color(0x33BBC5AA);     // Glow effect for secondary

  // --- Common Colors ---
  static const Color white = Colors.white; // Keep white for things that are always white.
  static const Color grey = Colors.grey;   // Keep grey for general purpose.
  static const Color error = Color(0xFFFF4949); // A standard error red.
}
