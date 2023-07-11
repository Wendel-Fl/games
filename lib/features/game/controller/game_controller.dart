import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

class GameController {
  // GET
  Future<void> loadGames() async {
    /*http://206.189.206.44:8080/api/jogo?page={pagina}*/

    const url = '${Constants.url}/api/jogo?page=1';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final _token = sharedPreferences.getString('token');
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: 'Authorization: $_token'},
    );
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
  }
}
