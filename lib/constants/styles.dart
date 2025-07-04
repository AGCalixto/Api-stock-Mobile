import 'package:flutter/material.dart';
import 'colors.dart';

class AppStyles {
  // General paddings
  static const sectionPadding = EdgeInsets.all(16);
  static const buttonPadding = EdgeInsets.symmetric(horizontal: 24, vertical: 16);

  // Typography
  static const fontFamily = 'Sen';

  static const boldText = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const sectionHeader = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const secondaryText = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.textSecondary,
  );

  static const stockPrice = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static const stockChange = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const portfolioValue = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const buttonText = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  // Buttons
  static final primaryButton = ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll(AppColors.primary),
    foregroundColor: const MaterialStatePropertyAll(AppColors.background),
    padding: const MaterialStatePropertyAll(buttonPadding),
    textStyle: const MaterialStatePropertyAll(buttonText),
  );

  static final outlineButton = ButtonStyle(
    side: const MaterialStatePropertyAll(BorderSide(color: AppColors.primary)),
    foregroundColor: const MaterialStatePropertyAll(AppColors.primary),
    padding: const MaterialStatePropertyAll(buttonPadding),
    textStyle: const MaterialStatePropertyAll(buttonText),
  );

  // Cards
  static const cardDecoration = BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.all(Radius.circular(12)),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6,
        offset: Offset(0, 4),
      ),
    ],
  );
}
