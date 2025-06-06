import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class SetupUserProfileImageWidget extends StatefulWidget {
  const SetupUserProfileImageWidget({super.key, this.onImagePicked});
  final Function(String?)? onImagePicked;

  @override
  State<SetupUserProfileImageWidget> createState() =>
      _SetupUserProfileImageWidgetState();
}

class _SetupUserProfileImageWidgetState
    extends State<SetupUserProfileImageWidget> {
  File? _imageFile;
  final _imagePicker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      /// To save the profile picture in a permanent path
      final directory = await getApplicationDocumentsDirectory();
      final newPath = '${directory.path}/${image.name}';
      final newImage = await File(image.path).copy(newPath);
      setState(() {
        _imageFile = newImage;
      });
      widget.onImagePicked?.call(newPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            _imageFile == null
                ? const CircleAvatar(
                  radius: 55,
                  backgroundColor: AppColors.container,
                  child: Icon(
                    FontAwesomeIcons.camera,
                    color: AppColors.textContainer,
                  ),
                )
                : CircleAvatar(
                  radius: 55,
                  backgroundImage: FileImage(_imageFile!),
                ),
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.primaryLight,
                        AppColors.primaryExtraLight,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(
                    FontAwesomeIcons.pen,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Text(AppStrings.edit, style: AppTextStyles.semiBold14),
      ],
    );
  }
}
