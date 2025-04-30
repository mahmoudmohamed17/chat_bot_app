import 'package:flutter/material.dart';

class OtpWidget extends StatefulWidget {
  const OtpWidget({super.key, required this.onCompleted, required this.length});
  final void Function(String code) onCompleted;
  final int length;
  @override
  State<OtpWidget> createState() => _SimpleOtpWidgetState();
}

class _SimpleOtpWidgetState extends State<OtpWidget> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(widget.length, (_) => TextEditingController());
    focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void handleInput(String value, int index) {
    if (value.length == 1 && index < widget.length - 1) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
    checkAllFilled();
  }

  void checkAllFilled() {
    final code = controllers.map((c) => c.text).join();
    bool isAllFilled = controllers.every((c) => c.text.isNotEmpty);
    if (code.length == widget.length && isAllFilled) {
      widget.onCompleted.call(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        return Container(
          width: 50,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            decoration: const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => handleInput(value, index),
          ),
        );
      }),
    );
  }
}
