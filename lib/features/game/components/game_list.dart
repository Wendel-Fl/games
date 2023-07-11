import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/game.dart';
import 'game_item.dart';

class GameList extends StatelessWidget {
  final List<Game> games;

  const GameList(this.games, {super.key});

  factory GameList.fromJson(Map<String, dynamic> json) {
    final List<dynamic> gameList = json['content'];
    final games = gameList.map((gameJson) => Game.fromJson(gameJson)).toList();

    return GameList(games);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(6.0),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: games.length,
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          value: games[index],
          child: Consumer<Game>(
            builder: (ctx, game, _) => const GameItem(),
          ),
        ),
      ),
    );
  }
}
