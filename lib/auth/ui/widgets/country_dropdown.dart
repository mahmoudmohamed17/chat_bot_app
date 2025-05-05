import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CountryDropdown extends StatefulWidget {
  final void Function(String? value)? onChanged;

  const CountryDropdown({super.key, this.onChanged});

  @override
  State<CountryDropdown> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  String selectedValue = '+1';
  String selectedFlag = Assets.imagesUsaFlag;
  bool _isTapped = false;

  final List<Map<String, String>> countries = [
    {'code': '+20', 'flag': Assets.imagesEgyFlag},
    {'code': '+966', 'flag': Assets.imagesSaFlag},
    {'code': '+1', 'flag': Assets.imagesUsaFlag},
  ];

  final GlobalKey _key = GlobalKey();

  void _showMenu() async {
    final RenderBox renderBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final result = await showMenu<Map<String, String>>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height + 4,
        offset.dx + size.width,
        0,
      ),
      items:
          countries.map((country) {
            return PopupMenuItem<Map<String, String>>(
              value: country,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Image.asset(country['flag']!, width: 20, height: 20),
                  Text(country['code']!),
                ],
              ),
            );
          }).toList(),
    );

    if (result != null) {
      setState(() {
        selectedValue = result['code']!;
        selectedFlag = result['flag']!;
        _isTapped = !_isTapped;
      });
      if (widget.onChanged != null) {
        widget.onChanged!(selectedValue);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: () {
        _showMenu();
        setState(() {
          _isTapped = !_isTapped;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
        decoration: BoxDecoration(
          color: AppColors.container,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 4,
          children: [
            Image.asset(selectedFlag, height: 20, width: 20),
            Text(selectedValue, style: AppTextStyles.medium12),
            Icon(
              _isTapped ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
