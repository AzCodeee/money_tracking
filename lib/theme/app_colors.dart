// lib/theme/app_colors.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  // -----------------------
  // Base color values (light / dark)
  // -----------------------
  static const Color _lightPrimary = Color(0xFF081324); // bright blue
  static const Color _darkPrimary  = Color(0xFFF6F7F8); // lighter in dark mode
 
  static const Color _lightBackground = Color(0xFFF9FAFB);
  static const Color _darkBackground  = Color(0xFF121212);

  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _darkSurface  = Color(0xFF1E1E1E);

  static const Color _lightTextPrimary   = Color(0xFF111111);
  static const Color _darkTextPrimary    = Color(0xFFFFFFFF);

  static const Color _lightTextSecondary = Color(0xFF6B7280);
  static const Color _darkTextSecondary  = Color(0xFFA1A1AA);

  // Feedback colors (same across themes)
  static const Color income  = Color(0xFF22C55E);
  static const Color expense = Color(0xFFEF4444);

  static const Color _lightBorder = Color(0xFFE5E7EB);
  static const Color _darkBorder  = Color(0xFF27272A);

  // -----------------------
  // Semantic getters (use these in UI)
  // -----------------------
  // Use Get.isDarkMode (requires GetX) so colors adapt automatically
  static bool get _dark => Get.isDarkMode;

  // primary / accent
  static Color get primary => _dark ? _darkPrimary : _lightPrimary;
  static Color get accent  => primary; // alias - keep palette minimal

  // backgrounds / surfaces
  static Color get bg    => _dark ? _darkBackground : _lightBackground;
  static Color get card  => _dark ? _darkSurface : _lightSurface;

  // text
  static Color get textPrimary   => _dark ? _darkTextPrimary : _lightTextPrimary;
  static Color get textSecondary => _dark ? _darkTextSecondary : _lightTextSecondary;

  // border/divider
  static Color get border => _dark ? _darkBorder : _lightBorder;
}
