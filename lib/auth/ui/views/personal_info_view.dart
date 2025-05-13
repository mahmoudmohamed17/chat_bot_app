import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_date_of_birth_widget.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_text_form_field.dart';
import 'package:chat_bot_app/auth/ui/widgets/setup_user_phone_number_widget.dart';
import 'package:chat_bot_app/auth/ui/widgets/setup_user_profile_image_widget.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/managers/users_cubit/users_cubit.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/utils/snack_bar.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({super.key});

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersState>(
      listener: (context, state) {
        if (state is UsersSuccess) {
          context.push(Routes.pinCodeView);
        }
        if (state is UsersFailed) {
          snackBar(context, title: state.errorMsg);
        }
      },
      builder: (context, state) {
        var cubit = context.read<UsersCubit>();
        return ModalProgressHUD(
          inAsyncCall: state is UsersLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: customAppBar(context, title: AppStrings.personalInfo),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                SetupUserProfileImageWidget(
                  onImagePicked: (image) {
                    cubit.profilePicture = image;
                  },
                ),
                const SizedBox(height: 32),
                CustomTextFormField(
                  hintText: AppStrings.fullName,
                  controller: nameController,
                ),
                const SizedBox(height: 12),
                SetupUserPhoneNumberWidget(
                  onEditingFinished: (number) {
                    cubit.phoneNumber = number;
                  },
                ),
                const SizedBox(height: 12),
                CustomDateOfBirthWidget(
                  onDateSelected: (date) {
                    cubit.dateOfBirth = date;
                  },
                ),
                const Expanded(child: SizedBox(height: 280)),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    label: AppStrings.next,
                    backgroundColor: AppColors.primary,
                    labelColor: Colors.white,
                    onPressed: () async {
                      cubit.fullName = nameController.text;
                      await cubit.addUser();
                      await cubit.getUser();
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
