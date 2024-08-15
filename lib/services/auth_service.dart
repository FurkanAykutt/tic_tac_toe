import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final GoTrueClient _auth;

  AuthService(this._auth);

  Future<AuthResponse> signIn() async {
    return _auth.signInAnonymously();
  }

  bool get isLoggedIn => _auth.currentUser != null;

  String get userId => _auth.currentUser!.id;
}
