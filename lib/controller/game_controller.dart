import 'dart:convert';

import '../utils/app_routes.dart';
import 'package:http/http.dart' as http;

class GameController {

  // GET
  Future<void> loadGames() async {
    const url = 'http://206.189.206.44:8080';
    final response = await http.get(Uri.parse(url));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
  }
}