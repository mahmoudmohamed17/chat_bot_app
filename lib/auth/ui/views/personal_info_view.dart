import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_date_of_birth_widget.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_text_form_field.dart';
import 'package:chat_bot_app/auth/ui/widgets/setup_user_profile_image_widget.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class PersonalInfoView extends StatelessWidget {
  const PersonalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(context, title: AppStrings.personalInfo),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          SetupUserProfileImageWidget(
            onImagePicked: (image) {
            },
          ),
          const SizedBox(height: 32),
          const CustomTextFormField(hintText: AppStrings.emailAddress),
          const SizedBox(height: 12),
          const CustomTextFormField(
            hintText: AppStrings.phoneNumber,
            textInputType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          CustomDateOfBirthWidget(onDateSelected: (date) {}),
          const Expanded(child: SizedBox(height: 280)),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              label: AppStrings.confirm,
              backgroundColor: AppColors.primary,
              labelColor: Colors.white,
              onPressed: () {
                // context.push(Routes.selectGenderView);
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
