import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  DateTime? _expiresIn;

  bool get isAuth {
    final isValid = _expiresIn?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  Future<void> login(String email, String password) async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String token = sharedPreferences.getString();
    final url = Uri.parse('http://206.189.206.44:8080/login');
    final response = await http.post(
      url,
      body: jsonEncode(
        {
          'email': email,
          'senha': password,
        },
      ),
      headers: {'Content-Type': 'application/json'},
    );

    // final body = jsonDecode(response.body);

    // if (body['error'] != null) {
    //   print('erro');
    // } else {
    //   _email = body['email'];
    //
    // }

    if (response.statusCode == 200) {
      print(json.decode(response.body));
    } else {
      print(response.statusCode);
    }
    notifyListeners();
  }
}
