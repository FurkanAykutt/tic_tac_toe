import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tic_tac_toe/constants/secrets.dart';

import '../services/auth_service.dart';
import '../services/code_manager.dart';
import '../services/game_service.dart';

class Dependencies {
  final AuthService authService;
  final GameService gameService;

  Dependencies._(this.authService, this.gameService);

  static Future<Dependencies> get init async {
    final supabase = await Supabase.initialize(
      url: Secrets.supabaseURL,
      anonKey: Secrets.anonKey,
    );
    final authService = AuthService(supabase.client.auth);
    final gameService = GameService(supabase.client, CodeManager());
    return Dependencies._(authService, gameService);
  }
}
