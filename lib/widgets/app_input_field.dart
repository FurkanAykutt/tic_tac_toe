import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/theme.dart';

class AppInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextDirection? textDirection;
  final List<TextInputFormatter> inputFormatters;

  factory AppInputField.number({
    Key? key,
    required TextEditingController controller,
  }) {
    return AppInputField(
      key: key,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      textDirection: TextDirection.rtl,
    );
  }

  const AppInputField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.inputFormatters = const [],
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      child: TextField(
        keyboardType: keyboardType,
        textDirection: textDirection,
        controller: controller,
        inputFormatters: inputFormatters,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            borderSide: BorderSide(
              color: supabaseGreen,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
