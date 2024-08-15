import 'dart:developer';

import 'package:flutter/material.dart';

class ScreenLoader<T> extends StatelessWidget {
  final String loadingText;

  const ScreenLoader({
    super.key,
    required this.future,
    required this.builder,
    this.loadingText = 'Loading...',
  });

  final Future<T> future;
  final Widget Function(BuildContext, T) builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        bool ready = snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null;
        if (snapshot.hasError) {
          log('Error loading screen', error: snapshot.error);
        }
        return Scaffold(
          body: ready
              ? builder(context, snapshot.data!)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(loadingText),
                    )
                  ],
                ),
        );
      },
    );
  }
}
