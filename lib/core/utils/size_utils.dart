import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';

/// Utility class for responsive sizing
class SizeUtils {
  SizeUtils._();

  /// Get responsive width multiplier
  static double w(BuildContext context, double px) {
    final width = MediaQuery.of(context).size.width;
    return px * width / AppDimensions.referenceWidth;
  }

  /// Get responsive height multiplier
  static double h(BuildContext context, double px) {
    final height = MediaQuery.of(context).size.height;
    return px * height / AppDimensions.referenceHeight;
  }

  /// Get responsive font size multiplier
  static double fs(BuildContext context, double px) {
    final width = MediaQuery.of(context).size.width;
    return px * width / AppDimensions.referenceWidth;
  }
}

/// Extension methods for easier access
extension SizeExtension on BuildContext {
  double w(double px) => SizeUtils.w(this, px);
  double h(double px) => SizeUtils.h(this, px);
  double fs(double px) => SizeUtils.fs(this, px);
}
