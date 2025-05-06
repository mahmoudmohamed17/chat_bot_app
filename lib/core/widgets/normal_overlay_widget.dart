import 'dart:ui';
import 'package:chat_bot_app/core/utils/get_color_opacity.dart';
import 'package:flutter/material.dart';

class NormalOverlayWidget extends StatelessWidget {
  final Widget child;
  final Widget dialogBody;

  const NormalOverlayWidget({
    super.key,
    required this.child,
    required this.dialogBody,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              color: getColorOpacity(Colors.black, 0.3),
              alignment: Alignment.center,
              child: dialogBody,
            ),
          ),
        ),
      ],
    );
  }
}
