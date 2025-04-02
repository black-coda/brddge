import 'package:flutter/material.dart' show EdgeInsets;

class AppConstant {
  const AppConstant._();

  static const String googleSvgPath = 'assets/images/google-icon-logo.svg';
  static const String closedEyeSvgPath = 'assets/images/eye_closed.svg';
  static const String openEyeSvgPath = 'assets/images/eye_open.svg';

  static EdgeInsets scaffoldPadding({
    double top = 0,
    double bottom = 0,
    double left = 16,
    double right = 16,
  }) =>
      EdgeInsets.only(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
      );
}
