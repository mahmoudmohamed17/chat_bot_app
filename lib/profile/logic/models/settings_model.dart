import 'package:flutter/widgets.dart';

class SettingsModel {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  SettingsModel({required this.title, required this.icon, required this.onTap});
}
