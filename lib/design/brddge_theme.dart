import 'package:brddge/design/brddge_color.dart';
import 'package:flutter/material.dart';

class BrddgeTheme {
  const BrddgeTheme._();

  static ThemeData get theme => ThemeData(
        fontFamily: 'Gilory',
        scaffoldBackgroundColor: BrddgeColor.scaffoldBackgroundColor,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: BrddgeColor.richBlack,
          circularTrackColor: BrddgeColor.cornsilk,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: BrddgeColor.cornsilk,
            foregroundColor: BrddgeColor.richBlack,
            disabledBackgroundColor: BrddgeColor.elevatedDisabledButtonColor,
            disabledForegroundColor: BrddgeColor.richBlack,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: BrddgeColor.scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: BrddgeColor.white,
          ),
          toolbarHeight: 88,
        ),
      );
}
