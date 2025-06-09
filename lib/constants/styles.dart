import 'package:flutter/material.dart';
import 'colors.dart';

class AppStyles {
  static const primaryButton = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(AppColors.primary),
    foregroundColor: MaterialStatePropertyAll(AppColors.background),
    padding: MaterialStatePropertyAll(
      EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    ),
    textStyle: MaterialStatePropertyAll(
      TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );

  static const outlineButton = ButtonStyle(
    side: MaterialStatePropertyAll(BorderSide(color: AppColors.primary)),
    foregroundColor: MaterialStatePropertyAll(AppColors.primary),
    padding: MaterialStatePropertyAll(
      EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    ),
    textStyle: MaterialStatePropertyAll(
      TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );

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

  static const sectionHeader = TextStyle(
    fontFamily: 'Sen',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const stockPrice = TextStyle(
    fontFamily: 'Sen',
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static const stockChange = TextStyle(
    fontFamily: 'Sen',
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const portfolioValue = TextStyle(
    fontFamily: 'Sen',
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
}