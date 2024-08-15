import 'package:flutter/material.dart';

import '../models/game.dart';
import '../services/services.dart';
import 'game/host_game_view.dart';

class GamesListScreen extends StatelessWidget {
  const GamesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games List'),
      ),
      body: StreamBuilder<List<Game>>(
        stream: Services.of(context).gameService.streamGames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No games available'));
          }

          final games = snapshot.data!;

          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              return ListTile(
                title: Text('Game Name: ${game.gameName}'),
                subtitle: Text('Status: ${game.status}'),
                onTap: () async {
                  if (game.status == 'pending') {
                    try {
                      final joinedGame = await Services.of(context)
                          .gameService
                          .joinGame(game.code);
                      // Oyuna başarıyla katıldı, oyunun detay sayfasına yönlendir
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HostGameView(
                            game: joinedGame,
                            gameService: Services.of(context).gameService,
                          ),
                        ),
                      );
                    } catch (e) {
                      // Hata durumunda kullanıcıya bildirim
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to join game: $e')),
                      );
                    }
                  } else {
                    // Eğer oyun "waiting" değilse, kullanıcıya bildirim
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('This game is not available to join')),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
