import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './app_colors.dart';

class AppTextStyles {
  static TextTheme get textTheme => TextTheme(
        displayLarge: GoogleFonts.orbitron(
          fontSize: 52,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          shadows: _createGlow(AppColors.primary),
        ),
        headlineLarge: GoogleFonts.manrope(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        titleMedium: GoogleFonts.manrope(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        bodyMedium: GoogleFonts.manrope(
          fontSize: 16,
          color: AppColors.white.withOpacity(0.8),
        ),
        labelMedium: GoogleFonts.manrope(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
      );

  static List<Shadow> _createGlow(Color color) => [
        Shadow(
          blurRadius: 20.0,
          color: color.withOpacity(0.8),
          offset: const Offset(0, 0),
        ),
        Shadow(
          blurRadius: 30.0,
          color: color.withOpacity(0.6),
          offset: const Offset(0, 0),
        ),
      ];
}
