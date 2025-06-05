import 'package:animate_do/animate_do.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_loadingkit/flutter_animated_loadingkit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingComment extends StatelessWidget {
  const CustomLoadingComment({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        width: 100,
        padding: const EdgeInsets.all(16),
        child: const SpinKitThreeBounce(
          color: Colors.black,
          size: 18,
          duration: Duration(milliseconds: 600),
        ),
      ),
    );
  }
}
