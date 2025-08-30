import 'package:flutter/material.dart';
import './app_colors.dart';
import './app_text_styles.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: AppTextStyles.textTheme,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        background: AppColors.darkBackground,
        surface: AppColors.darkSurface,
        error: AppColors.error,
      ),
      cardTheme: CardTheme(
        color: AppColors.darkSurface,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.primary.withOpacity(0.3)),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface.withOpacity(0.8),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        selectedLabelStyle: AppTextStyles.textTheme.labelMedium,
        unselectedLabelStyle: AppTextStyles.textTheme.labelMedium?.copyWith(color: AppColors.grey),
      ),
    );
  }

  static ThemeData get lightTheme {
    // For now, we focus on a stellar dark theme.
    // A light theme can be built out here later.
    return ThemeData.light(useMaterial3: true).copyWith(
       primaryColor: AppColors.primary,
       colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        background: AppColors.lightBackground,
        surface: AppColors.lightSurface,
        error: AppColors.error,
      ),
    );
  }
}
