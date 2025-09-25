import 'package:flutter/material.dart';

class Spacing {
  // Padding and margin constants
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // Custom edge insets
  static EdgeInsets all(double spacing) => EdgeInsets.all(spacing);
  static EdgeInsets horizontal(double spacing) =>
      EdgeInsets.symmetric(horizontal: spacing);
  static EdgeInsets vertical(double spacing) =>
      EdgeInsets.symmetric(vertical: spacing);
  static EdgeInsets symmetric({double vertical = 0, double horizontal = 0}) =>
      EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal);
  static EdgeInsets only({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) =>
      EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      );

  // Specific spacing constants
  static const EdgeInsets pagePadding = EdgeInsets.all(md);
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const EdgeInsets buttonPadding =
  EdgeInsets.symmetric(vertical: sm, horizontal: md);
}