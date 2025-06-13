import 'dart:async';
import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResendCodeWidget extends StatefulWidget {
  const ResendCodeWidget({super.key, required this.email});
  final String email;

  @override
  State<ResendCodeWidget> createState() => _ResendCodeWidgetState();
}

class _ResendCodeWidgetState extends State<ResendCodeWidget> {
  late TapGestureRecognizer _tapGestureRecognizer;
  int _seconds = 60;
  Timer? _timer;
  bool _canResend = false;
  @override
  void initState() {
    super.initState();
    _startTimer();
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = _resendCode;
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _seconds = 60;
      _canResend = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  void _resendCode() {
    context.read<AuthCubit>().signInWithOTP(email: widget.email).then((value) {
      _startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          _canResend
              ? TextSpan(
                text: context.tr(AppStrings.resendCode),
                recognizer: _tapGestureRecognizer,
                style: AppTextStyles.medium12.copyWith(
                  color: AppColors.primary,
                ),
              )
              : TextSpan(
                children: [
                  const TextSpan(style: AppTextStyles.medium14),
                  TextSpan(
                    text: _seconds.toString(),
                    style: AppTextStyles.medium14.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  TextSpan(
                    text: ' ${context.tr(AppStrings.second)}',
                    style: AppTextStyles.medium14,
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
