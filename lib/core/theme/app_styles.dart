import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract class AppStyles {
  static TextStyle bold20Black = GoogleFonts.inter(
      fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.black);
  static TextStyle bold16Black = GoogleFonts.inter(
      fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.black);
  static TextStyle bold14Black = GoogleFonts.inter(
      fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.black);

  static TextStyle bold20LightBlue = GoogleFonts.inter(
      fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.lightBlue);
  static TextStyle bold16lightBlue = GoogleFonts.inter(
      fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.lightBlue);
  static TextStyle bold14lightBlue = GoogleFonts.inter(
      fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.lightBlue);

  static TextStyle bold20darkBlue = GoogleFonts.inter(
      fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.darkBlue);
  static TextStyle bold16darkBlue = GoogleFonts.inter(
      fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.darkBlue);
  static TextStyle bold14darkBlue = GoogleFonts.inter(
      fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.darkBlue);
}
