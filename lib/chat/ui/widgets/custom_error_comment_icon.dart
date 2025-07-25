
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CustomErrorCommentIcon extends StatelessWidget {
  const CustomErrorCommentIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}