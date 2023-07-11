import 'package:flutter/material.dart';
import 'package:games/features/auth/page/auth_page.dart';
import 'package:games/features/game/page/game_overview_page.dart';
import 'package:provider/provider.dart';

import '../features/auth/controller/auth_controller.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController auth = Provider.of(context);

    return auth.isAuth ? const GameOverviewPage() : const AuthPage();
  }
}
