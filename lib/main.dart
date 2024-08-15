import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'init/dependencies.dart';
import 'services/services.dart';
import 'theme/theme.dart';
import 'views/entry_name_screen.dart';
import 'views/title_screen.dart';
import 'widgets/app_screen.dart';
import 'widgets/screen_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dependencies = await Dependencies.init;
  runApp(TicTacToe(dependencies: dependencies));
}

class TicTacToe extends StatelessWidget {
  final Dependencies dependencies;

  const TicTacToe({super.key, required this.dependencies});

  Future<String?> _getNickname() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nickname');
  }

  @override
  Widget build(BuildContext context) {
    return Services(
      dependencies: dependencies,
      child: MaterialApp(
        title: 'Tic Tac Toe',
        theme: theme,
        home: AppScreen(
          child: ScreenLoader(
            future: dependencies.authService.signIn(),
            builder: (context, _) {
              return FutureBuilder<String?>(
                future: _getNickname(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return TitleScreen(nickname: snapshot.data!);
                  } else {
                    return EntryNameScreen();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
