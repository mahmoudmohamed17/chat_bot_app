import 'package:flutter/material.dart';

Color getColorOpacity(Color color, double opacity) {
  int newAlpha = (opacity * 255).toInt();
  return color.withAlpha(newAlpha);
}
