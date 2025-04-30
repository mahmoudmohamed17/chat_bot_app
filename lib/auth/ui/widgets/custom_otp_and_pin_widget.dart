import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomOtpAndPinWidget extends StatefulWidget {
  const CustomOtpAndPinWidget({super.key, required this.onCompleted, required this.length, required this.isForPIN});
  final void Function(String code) onCompleted;
  final int length;
  final bool isForPIN;
  @override
  State<CustomOtpAndPinWidget> createState() => _SimpleOtpWidgetState();
}

class _SimpleOtpWidgetState extends State<CustomOtpAndPinWidget> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(widget.length, (_) => TextEditingController());
    focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void handleInput(String value, int index) {
    if (value.length == 1 && index < widget.length - 1) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
    checkAllFilled();
  }

  void checkAllFilled() {
    final code = controllers.map((c) => c.text).join();
    bool isAllFilled = controllers.every((c) => c.text.isNotEmpty);
    if (code.length == widget.length && isAllFilled) {
      FocusScope.of(context).unfocus(); // Disable keyboard automatically
      widget.onCompleted.call(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        return Container(
          width: 50,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            obscureText: widget.isForPIN ? true : false,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: AppTextStyles.bold18,
            keyboardAppearance: Brightness.dark,
            decoration: InputDecoration(
              counterText: '',
              focusColor: Colors.transparent,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.container,
                  width: 0,
                ),
              ),
              fillColor: AppColors.container,
              filled: true,
            ),
            onChanged: (value) => handleInput(value, index),
          ),
        );
      }),
    );
  }
}
