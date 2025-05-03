import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomCheckoutHintWidget extends StatefulWidget {
  const CustomCheckoutHintWidget({
    super.key,
    required this.hint,
    this.onSelected,
  });
  final String hint;
  final void Function(bool)? onSelected;

  @override
  State<CustomCheckoutHintWidget> createState() =>
      _CustomCheckoutHintWidgetState();
}

class _CustomCheckoutHintWidgetState extends State<CustomCheckoutHintWidget> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value!;
            });
            widget.onSelected?.call(_isChecked);
          },
          checkColor: Colors.white,
          activeColor: AppColors.primary,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Text(widget.hint, style: AppTextStyles.medium14),
      ],
    );
  }
}
