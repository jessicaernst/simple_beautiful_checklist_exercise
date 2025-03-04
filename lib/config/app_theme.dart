import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_beautiful_checklist_exercise/config/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme => ThemeData.dark().copyWith(
        textTheme: GoogleFonts.robotoMonoTextTheme(
          ThemeData.dark().textTheme,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: AppColors.selectedItemColor,
        ),
      );
}
