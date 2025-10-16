import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      surface: AppColors.card,
      onPrimary: Colors.white,
      onSurface: AppColors.textPrimary,
      secondary: AppColors.accent,
    ),
    cardColor: AppColors.card,
    dividerColor: AppColors.border,
    iconTheme: IconThemeData(color: AppColors.textPrimary),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: AppColors.textPrimary),
      bodySmall: TextStyle(color: AppColors.textSecondary),
      titleMedium: TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      surface: AppColors.card,
      onPrimary: Colors.black,
      onSurface: AppColors.textPrimary,
      secondary: AppColors.accent,
    ),
    cardColor: AppColors.card,
    dividerColor: AppColors.border,
    iconTheme: IconThemeData(color: AppColors.textPrimary),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: AppColors.textPrimary),
      bodySmall: TextStyle(color: AppColors.textSecondary),
      titleMedium: TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}
