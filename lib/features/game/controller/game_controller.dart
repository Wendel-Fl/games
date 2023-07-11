import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:games/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../components/game_list.dart';
import '../model/game.dart';

class GameController with ChangeNotifier {
  // ignore: prefer_final_fields
  String _token;
  // ignore: prefer_final_fields
  List<Game> _games = [];
  int _currentPage = 1;

  List<Game> get games => [..._games];

  GameController(this._token, this._games);

  int get gamesCount {
    return _games.length;
  }

  void nextPage() {
    _currentPage++;
  }

  // GET
  Future<void> loadGames() async {
    /*http://206.189.206.44:8080/api/jogo?page={pagina}*/

    final url = '${Constants.url}/api/jogo?page=$_currentPage';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': '$token'},
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final gameList = GameList.fromJson(jsonResponse);
      final List<Game> games = gameList.games;
      _games
          .clear(); // Limpa a lista atual antes de adicionar os jogos carregados
      _games.addAll(games); // Adiciona os jogos carregados à lista
      notifyListeners();
    } else {
      // Lida com o erro de resposta do servidor
      print(
          'Erro ao carregar os jogos. Código de status: ${response.statusCode}');
    }
  }
}
