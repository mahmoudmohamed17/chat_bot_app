import 'package:chat_bot_app/auth/ui/widgets/gender_item_widget.dart';
import 'package:flutter/material.dart';

class GenderSelectionWidget extends StatefulWidget {
  const GenderSelectionWidget({super.key, required this.onSelectedGender});
  final void Function(String?)? onSelectedGender;

  @override
  State<GenderSelectionWidget> createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  final List<String> _genders = ['Male', 'Female', 'Other'];
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: List.generate(_genders.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _activeIndex = index;
            });
            widget.onSelectedGender!.call(_genders[index]);
          },
          child: GenderItemWidget(
            text: _genders[index],
            isActive: _activeIndex == index,
          ),
        );
      }),
    );
  }
}
