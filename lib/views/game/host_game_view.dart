import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/game.dart';
import '../../models/game_status.dart';
import '../../routes/navigation.dart';
import '../../services/game_service.dart';
import '../../theme/theme.dart';
import '../../widgets/app_screen.dart';
import 'game_view.dart';

class HostGameView extends StatefulWidget {
  final Game game;
  final GameService gameService;

  const HostGameView({
    super.key,
    required this.game,
    required this.gameService,
  });

  @override
  State<HostGameView> createState() => _HostGameViewState();
}

class _HostGameViewState extends State<HostGameView> {
  late StreamSubscription _statusSubscription;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'GAME NAME',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.game.gameName,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: supabaseGreen),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Waiting for Player 2...',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _statusSubscription =
        widget.gameService.streamState(widget.game.id).listen((state) async {
      if (state.status == GameStatus.started) {
        switchScreen(context, GameView(game: widget.game));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _statusSubscription.cancel();
    super.dispose();
  }
}
