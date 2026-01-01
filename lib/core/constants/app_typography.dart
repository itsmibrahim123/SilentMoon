import 'package:flutter/material.dart';

/// Centralized typography styles for the app.
/// Define all fonts, sizes, and weights here and reuse across widgets.
class AppTypography {
  // Base font family names can be loaded from pubspec assets.
  static const String primaryFontFamily = 'HelveticaNeue';
  static const String secondaryFontFamily = 'Airbnb Cereal App';

  // Headline styles
  static const TextStyle h1 = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.08,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.08,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  static const TextStyle body = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.2,
  );
}
