import 'package:flutter/widgets.dart';

import '../init/dependencies.dart';
import 'auth_service.dart';
import 'game_service.dart';

class Services extends InheritedWidget {
  final AuthService authService;
  final GameService gameService;

  Services({
    super.key,
    required Dependencies dependencies,
    required super.child,
  })  : authService = dependencies.authService,
        gameService = dependencies.gameService;

  static Services of(BuildContext context) {
    final Services? result =
        context.dependOnInheritedWidgetOfExactType<Services>();
    assert(result != null, 'No Dependencies found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(Services oldWidget) {
    return false;
  }
}
