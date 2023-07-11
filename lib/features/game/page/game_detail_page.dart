import 'package:flutter/material.dart';

import '../model/game.dart';

class GameDetailPage extends StatelessWidget {
  const GameDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nome do Jogo'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.logout))],
      ),
      body: const Center(
        child: Text('Detalhes do jogo'),
      ),
    );
  }
}
