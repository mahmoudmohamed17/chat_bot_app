import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/auth/ui/widgets/gender_selection_widget.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/managers/users_cubit/users_cubit.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/utils/show_custom_dialog.dart';
import 'package:chat_bot_app/core/utils/snack_bar.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SelectGenderView extends StatefulWidget {
  const SelectGenderView({super.key});

  @override
  State<SelectGenderView> createState() => _SelectGenderViewState();
}

class _SelectGenderViewState extends State<SelectGenderView> {
  bool _dialogShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_dialogShown) {
      _dialogShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        showCustomDialog(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<UsersCubit>(),
      child: BlocConsumer<UsersCubit, UsersState>(
        listener: (context, state) {
          if (state is UsersSuccess) {
            context.push(Routes.personalInfoView);
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
              appBar: customAppBar(context),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        context.tr(AppStrings.yourGender),
                        style: AppTextStyles.bold28,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        context.tr(AppStrings.yourGenderHint),
                        style: AppTextStyles.regular16,
                      ),
                    ),
                    const SizedBox(height: 24),
                    GenderSelectionWidget(
                      onSelectedGender: (gender) {
                        cubit.gender = gender;
                      },
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        label: context.tr(AppStrings.next),
                        backgroundColor: AppColors.primary,
                        labelColor: Colors.white,
                        onPressed: () {
                          cubit.addUser();
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
