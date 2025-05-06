import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;

  double get safeHeight =>
      height -
      MediaQuery.paddingOf(this).top -
      MediaQuery.paddingOf(this).bottom;
  double get safeWidth =>
      width -
      MediaQuery.paddingOf(this).right -
      MediaQuery.paddingOf(this).left;
}
