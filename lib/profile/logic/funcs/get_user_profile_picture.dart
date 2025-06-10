import 'dart:io';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:flutter/material.dart';

ImageProvider getUserProfilePicture(String? path) {
  if (path == null || path.isEmpty) {
    return const AssetImage(Assets.imagesProfilePic);
  } else if (path.startsWith('https://') || path.startsWith('http://')) {
    return NetworkImage(path);
  } else if (File(path).existsSync()) {
    return FileImage(File(path));
  } else {
    return const AssetImage(Assets.imagesProfilePic);
  }
}
