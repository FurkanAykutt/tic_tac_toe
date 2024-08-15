import 'package:flutter/material.dart';

import '../widgets/app_screen.dart';

void switchScreen(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => AppScreen(
        child: widget,
      ),
    ),
  );
}
