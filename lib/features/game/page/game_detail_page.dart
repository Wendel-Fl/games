import 'package:flutter/material.dart';
import 'package:games/features/auth/components/logout_button.dart';
import 'package:provider/provider.dart';

import '../model/game.dart';

class GameDetailPage extends StatelessWidget {
  const GameDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final game = ModalRoute.of(context)!.settings.arguments as Game;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(game.nome),
        actions: const [LogoutButton()],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(),
            Container(
              width: 300,
              child: Text(game.descricao),
            ),
            Container(),
            Row(
              children: [
                const Icon(Icons.info_outline),
                Text(
                  game.expansao == true
                      ? 'Este é um jogo do tipo expansão'
                      : '',
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
