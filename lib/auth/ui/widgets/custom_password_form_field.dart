import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomPasswordFormField extends StatefulWidget {
  const CustomPasswordFormField({
    super.key,
    required this.hintText,
    this.textInputType = TextInputType.text,
    required this.controller,
  });
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController controller;

  @override
  State<CustomPasswordFormField> createState() =>
      _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: AppTextStyles.regular16,
      obscureText: !_isVisible,
      validator: (value) {
        if (value!.isEmpty) {
          return '${widget.hintText} is required';
        } else {
          return null;
        }
      },
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyles.regular16.copyWith(
          color: AppColors.textContainer,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isVisible = !_isVisible;
            });
          },
          icon: Icon(
            _isVisible ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
            size: 18,
            color: Colors.black,
          ),
        ),
        fillColor: AppColors.container,
        contentPadding: const EdgeInsets.all(16),
        filled: true,
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }
}

OutlineInputBorder buildBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: Colors.transparent),
  );
}
