
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/profile/logic/managers/mode_cubit/mode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ChangingEmptyTopicsPicture extends StatelessWidget {
  const ChangingEmptyTopicsPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModeCubit, bool>(
      builder: (context, state) {
        return SvgPicture.asset(
          Assets.imagesEmptyFolder,
          height: 150,
          width: 150,
          colorFilter:
              context.read<ModeCubit>().state
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : null,
        );
      },
    );
  }
}