import 'package:flutter/material.dart' show FontWeight, TextStyle;

class BrddgeTypeface {
  BrddgeTypeface._();

  static TextStyle get title => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get subtitle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get elevatedButtonText => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get bodyText => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
}
