import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/managers/users_cubit/users_cubit.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/profile/logic/funcs/get_user_profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileBadge extends StatelessWidget {
  const UserProfileBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = context.read<UsersCubit>().user;
    final authUser = context.read<AuthCubit>().currentUser;
    return ListTile(
      onTap: () {},
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: getUserProfilePicture(userData?.profilePicture),
      ),
      title: Text(
        userData?.fullName ?? AppStrings.dummyUsername,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.bold16,
      ),
      subtitle: Text(
        authUser.email ?? AppStrings.dummyUserEmail,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.regular12.copyWith(color: AppColors.textContainer),
      ),
    );
  }
}
