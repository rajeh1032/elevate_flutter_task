import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: GoogleFonts.inter().fontFamily,
    primaryColor: AppColors.blue,
 
  );
}
