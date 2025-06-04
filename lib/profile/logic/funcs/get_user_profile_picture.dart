import 'dart:io';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:flutter/material.dart';

ImageProvider getUserProfilePicture(String? path) {
  return const AssetImage(Assets.imagesProfilePic);
  // if (path.contains(RegExp(r'^https?://'))) {
  //   return NetworkImage(path);
  // } else if (File(path).existsSync()) {
  //   return FileImage(File(path));
  // } else {
  //   return FileImage(File(Assets.imagesProfilePic));
  // }
}
