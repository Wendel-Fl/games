import 'package:flutter/material.dart';
import 'package:games/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../model/game.dart';

class GameList {
  final List<Game> games;

  const GameList(this.games);

  factory GameList.fromJson(Map<String, dynamic> json) {
    final List<dynamic> gameList = json['content'];
    final games = gameList.map((gameJson) => Game.fromJson(gameJson)).toList();

    return GameList(games);
  }
}
