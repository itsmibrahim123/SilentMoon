import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// App theme configuration
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryPurple,
        secondary: AppColors.primaryDark,
        surface: AppColors.backgroundWhite,
        error: AppColors.accentRed,
      ),
      scaffoldBackgroundColor: AppColors.backgroundWhite,
      fontFamily: 'HelveticaNeue',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'HelveticaNeue',
          fontWeight: FontWeight.w700,
          fontSize: 34,
          color: AppColors.textPrimary,
          height: 1.081,
        ),
        displayMedium: TextStyle(
          fontFamily: 'HelveticaNeue',
          fontWeight: FontWeight.w700,
          fontSize: 28,
          color: AppColors.textPrimary,
          height: 1.35,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'HelveticaNeue',
          fontWeight: FontWeight.bold,
          fontSize: 28,
          color: AppColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'HelveticaNeue',
          fontWeight: FontWeight.w300,
          fontSize: 28,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontFamily: 'HelveticaNeue',
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontFamily: 'HelveticaNeue',
          fontWeight: FontWeight.w400,
          fontSize: 18,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'HelveticaNeue',
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: AppColors.textPrimary,
          height: 1.45,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'HelveticaNeue',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: AppColors.textSecondary,
          height: 1.081,
        ),
        bodySmall: TextStyle(
          fontFamily: 'HelveticaNeue',
          fontWeight: FontWeight.w300,
          fontSize: 12,
          color: AppColors.textSecondary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryPurple,
          foregroundColor: AppColors.textWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(38),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          textStyle: const TextStyle(
            fontFamily: 'HelveticaNeue',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: 0.7,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backgroundGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        hintStyle: const TextStyle(
          fontFamily: 'HelveticaNeue',
          fontWeight: FontWeight.w300,
          fontSize: 16,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryPurple,
        secondary: AppColors.primaryLight,
        surface: AppColors.backgroundDark,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      fontFamily: 'HelveticaNeue',
    );
  }
}
