import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color.fromARGB(255, 103, 58, 183); // Deep Purple
  static const Color counterBackground =
      Color.fromARGB(255, 128, 0, 128); // Purple
  static const Color shimmerBase = Color.fromARGB(255, 255, 255, 255); // Weiß

  static Color get accent =>
      const Color.fromARGB(255, 228, 132, 255).withAlpha((0.724 * 255).toInt());

  static Color get shimmerHighlight => accent;

  static Color get cardBackground =>
      const Color.fromARGB(255, 222, 103, 255).withAlpha(26); // 10% Deckkraft
}
