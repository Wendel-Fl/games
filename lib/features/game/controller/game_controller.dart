import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants.dart';
import '../components/game_list.dart';
import '../model/game.dart';

class GameController with ChangeNotifier {
  // ignore: prefer_final_fields
  String _token;

  // ignore: prefer_final_fields
  List<Game> _games = [];

  List<Game> get games => [..._games];

  GameController(this._token, this._games);

  int get gamesCount {
    return _games.length;
  }

  // GET
  Future<List<Game>> loadGames(int currentPage) async {
    final url = '${Constants.urlJogo}?page=$currentPage';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': '$token'},
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final gameList = GameList.fromJson(jsonResponse);
      final List<Game> games = gameList.games;
      return games;
    } else {
      return [];
    }
  }

  // GET
  Future loadCurrentGame(int idJogo) async {
    final url = '${Constants.urlJogo}/$idJogo';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': '$token'},
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final game = Game.fromJson(jsonResponse);
      notifyListeners();
      return game;
    } else {
      return 0;
    }
  }
}
