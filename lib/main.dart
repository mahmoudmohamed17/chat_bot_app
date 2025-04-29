import 'package:chat_bot_app/app.dart';
import 'package:chat_bot_app/core/utils/shared_pref.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  runApp(const MyApp());
}
