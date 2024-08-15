import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/game.dart';
import '../models/game_state.dart';
import '../models/game_status.dart';
import 'code_manager.dart';

class GameService {
  final SupabaseClient _supabaseClient;
  final CodeManager _codeManager;

  GameService(this._supabaseClient, this._codeManager);

  Future<Game> newGame(String gameName, Color boardColor) async {
    final game = await _supabaseClient
        .from('games')
        .insert({
          'game_name': gameName,
          'board_color': _codeManager.colorToHex(boardColor),
        })
        .select()
        .single();

    final gameId = game['id'];
    final gameStatus = game['status'];

    final gameCode = _codeManager.toCode(gameId);
    log('Created game with code $gameCode (ID $gameId)');
    return Game(gameId, gameCode, 1, gameStatus,
        _codeManager.colorToHex(boardColor), gameName);
  }

  Future<Game> joinGame(String gameCode) async {
    final gameId = _codeManager.toId(gameCode);
    log('Searching for game with code $gameCode (ID $gameId)');

    if (gameId == null) {
      throw InvalidGameCodeException('Invalid code');
    }

    final game = await _supabaseClient
        .from('games')
        .select()
        .eq('id', gameId)
        .maybeSingle();
    if (game == null) {
      throw InvalidGameCodeException('Invalid code');
    }

    final status = game['status'];
    log('Found game with status $status');
    if (status != 'pending') {
      throw InvalidGameCodeException('Game has already started');
    }

    await _supabaseClient
        .from('games')
        .update({'status': 'started'}).eq('id', gameId);

    final boardColor = game['board_color'];
    final gameName = game['game_name'];

    return Game(gameId, gameCode, 2, status, boardColor, gameName);
  }

  Future<void> playMove(Game game, GameState state, int index) async {
    if (state.lastPlayed == game.player || state.board[index] != 0) {
      return;
    }
    state.board[index] = game.player;
    await _supabaseClient.from('games').update({
      'board': state.board.join(),
      'last_played': game.player,
    }).eq('id', game.id);
  }

  Stream<GameState> streamState(int gameId) {
    return _supabaseClient
        .from('games')
        .stream(primaryKey: ['id'])
        .eq('id', gameId)
        .map((e) => toGameState(e.first));
  }

  GameState toGameState(Map<String, dynamic> game) {
    final status = GameStatus.fromString(game['status']);
    print(game['board']);
    final board = (game['board'] as String)
        .split('')
        .map((e) => int.tryParse(e) ?? 0)
        .toList();
    return GameState(status, board, game['last_played'], game['winner']);
  }

  Future<List<Game>> fetchGames() async {
    final response = await _supabaseClient.from('games').select();
    final data = response as List<dynamic>;

    return data.map((game) {
      final gameStatus = game['status'];
      final gameId = game['id'];
      final gameCode = _codeManager.toCode(gameId);
      final playerCount = game['player_count'] ?? 0;
      final boardColor = game['board_color'];
      final gameName = game['game_name'];
      return Game(
          gameId, gameCode, playerCount, gameStatus, boardColor, gameName);
    }).toList();
  }

  Stream<List<Game>> streamGames() {
    return _supabaseClient.from('games').stream(primaryKey: ['id']).map((data) {
      // 'data' listesi her bir oyun için bir harita içerir
      return data.map<Game>((game) {
        final gameId = game['id'];
        final gameCode = _codeManager.toCode(gameId);
        final boardColor = game['board_color'];
        final gameName = game['game_name'];
        return Game(gameId, gameCode, game['player_count'] ?? 0, game['status'],
            boardColor, gameName);
      }).toList();
    });
  }
}

class InvalidGameCodeException implements Exception {
  final String message;

  InvalidGameCodeException(this.message);
}
