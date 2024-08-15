import 'package:flutter/material.dart';

import '../widgets/app_button.dart';
import 'create_game_screen.dart';
import 'games_list_screen.dart';

class TitleScreen extends StatelessWidget {
  final String nickname;

  const TitleScreen({super.key, required this.nickname});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Welcome ${nickname}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        AppButton.expanded(
          label: 'Game List',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const GamesListScreen(),
              ),
            );
          },
        ),
        AppButton.expanded(
          label: 'Create game',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CreateGameScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
