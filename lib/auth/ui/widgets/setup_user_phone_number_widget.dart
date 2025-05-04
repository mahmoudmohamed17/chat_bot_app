import 'package:chat_bot_app/auth/ui/widgets/custom_text_form_field.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SetupUserPhoneNumberWidget extends StatefulWidget {
  const SetupUserPhoneNumberWidget({super.key, this.onEditingFinished});
  final void Function(String?)? onEditingFinished;

  @override
  State<SetupUserPhoneNumberWidget> createState() =>
      _SetupUserPhoneNumberWidgetState();
}

class _SetupUserPhoneNumberWidgetState
    extends State<SetupUserPhoneNumberWidget> {
  String? number;
  String? countryCode;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 12,
      children: [
        Expanded(
          child: DropdownMenu(
            initialSelection: '+1',
            inputDecorationTheme: InputDecorationTheme(
              fillColor: AppColors.container,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
            ),
            dropdownMenuEntries: [
              DropdownMenuEntry(
                value: '+20',
                label: '+20',
                leadingIcon: Image.asset(
                  Assets.imagesEgyFlag,
                  height: 20,
                  width: 20,
                ),
              ),
              DropdownMenuEntry(
                value: '+966',
                label: '+966',
                leadingIcon: Image.asset(
                  Assets.imagesSaFlag,
                  height: 20,
                  width: 20,
                ),
              ),
              DropdownMenuEntry(
                value: '+1',
                label: '+1',
                leadingIcon: Image.asset(
                  Assets.imagesUsaFlag,
                  height: 20,
                  width: 20,
                ),
              ),
            ],
            onSelected: (value) {
              countryCode = value;
            },
          ),
        ),
        Expanded(
          flex: 3,
          child: CustomTextFormField(
            onChanged: (value) {
              number = value;
              widget.onEditingFinished?.call('$countryCode$number');
            },
            hintText: AppStrings.phoneNumber,
            textInputType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
