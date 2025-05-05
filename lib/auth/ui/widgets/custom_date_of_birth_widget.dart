import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDateOfBirthWidget extends StatefulWidget {
  const CustomDateOfBirthWidget({super.key, required this.onDateSelected});
  final void Function(String) onDateSelected;

  @override
  State<CustomDateOfBirthWidget> createState() =>
      _CustomDateOfBirthWidgetState();
}

class _CustomDateOfBirthWidgetState extends State<CustomDateOfBirthWidget> {
  String? date;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.container,
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              date ?? AppStrings.dateOfBirth,
              style: AppTextStyles.regular16.copyWith(
                color: date == null ? AppColors.textContainer : Colors.black,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              showDatePicker(
                context: context,
                firstDate: DateTime(1970),
                lastDate: DateTime(2025),
              ).then((value) {
                if (value != null) {
                  date = '${value.day}/${value.month}/${value.year}';
                  widget.onDateSelected.call(date!);
                  setState(() {});
                } else {}
              });
            },
            icon: const Icon(FontAwesomeIcons.calendar, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
