import 'package:silent_moon/core/constants/app_colors.dart' as core;
import 'package:flutter/material.dart';

/// Legacy sleep feature color names mapped to the shared core palette.
/// Keeps existing imports working while ensuring colors are centralized.
class AppColors {
  AppColors._();

  static const Color darkBlue = core.AppColors.backgroundDark;
  static const Color whiteText = core.AppColors.primaryLight;
  static const Color blackText = core.AppColors.textPrimary;
  static const Color lightBlueText = core.AppColors.textLight;
  static const Color mutedBlueGrey = core.AppColors.textSecondary;

  static const Color sleepMusicGreen = core.AppColors.accentGreen;
  static const Color lightGreen = core.AppColors.cardGreen;
  static const Color lightOrange = core.AppColors.cardOrange;
  static const Color greyText = core.AppColors.textSecondary;
  static const Color faintBlack10 = core.AppColors.faintBlack10;

  static const Color faintWhite30 = core.AppColors.faintWhite30;
  static const Color faintWhite40 = core.AppColors.faintWhite40;
}
