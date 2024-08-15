import 'package:flutter/material.dart';

import '../theme/theme.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final bool expanded;

  const AppButton.expanded({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
  }) : expanded = true;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
  }) : expanded = false;

  @override
  Widget build(BuildContext context) {
    if (expanded) {
      return Row(
        children: [
          Expanded(
            child: _button(context),
          )
        ],
      );
    }
    return _button(context);
  }

  Widget _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Material(
        elevation: 8.0,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            side: const BorderSide(
              color: supabaseGreen,
              width: 2,
            ),
            backgroundColor: backgroundColor,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Text(
              label.toUpperCase(),
              style: Theme.of(context).primaryTextTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}
