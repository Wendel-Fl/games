import 'dart:convert';

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
  int _currentPage = 0;

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

    final url = '${Constants.urlJogo}?page=$_currentPage';
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
      // Limpa a lista atual antes de adicionar os jogos carregados
      _games.clear();
      // Adiciona os jogos carregados à lista
      _games.addAll(games);
      notifyListeners();
    } else {
      // Lida com o erro de resposta do servidor
      print(
        'Erro ao carregar os jogos. Código de status: ${response.statusCode}',
      );
    }
  }

  // GET
  Future<void> loadCurrentGame(int idJogo) async {
    /*http://206.189.206.44:8080/api/jogo/{id}*/

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
    } else {
      print(
        'Erro ao carregar os jogos. Código de status: ${response.statusCode}',
      );
    }
  }
}
