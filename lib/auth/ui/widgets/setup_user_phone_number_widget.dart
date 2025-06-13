import 'package:chat_bot_app/auth/ui/widgets/country_dropdown.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_text_form_field.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
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
      spacing: 8,
      children: [
        Expanded(
          child: CountryDropdown(
            onChanged: (value) {
              countryCode = value ?? '+1';
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
            hintText: context.tr(AppStrings.phoneNumber),
            textInputType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
