import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String text;

  const Heading({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
