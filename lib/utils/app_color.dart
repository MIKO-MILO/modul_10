import 'package:flutter/material.dart';

class AppColor {
static LinearGradient primaryGradient = LinearGradient(
colors: [primary, primarySoft],
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
);
static Color primary = Color(0xFF2167E6);
static Color primarySoft = Color(0xFF184AA6);
static Color primaryExtraSoft = Color(0xFFEFF3FC);
static Color secondary = Color(0xFF1B1F24);
static Color secondarySoft = Color(0xFF9D9D9D);
static Color secondaryExtraSoft = Color(0xFFE9E9E9);
static Color error = Color(0xFFD00E0E);
static Color success = Color(0xFF16AE26);
static Color warning = const Color(0xFFEB8600);
  static Color darkBlue = const Color(0xFF0D1B2A);
  static Color lightGray = const Color(0xFFF8F9FA);
  static Color accentRed = const Color(0xFFE63946);
}