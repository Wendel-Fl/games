import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiresIn;

  bool get isAuth {
    final isValid = _expiresIn?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  Future<void> login(String email, String password) async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String token = sharedPreferences.getString();
    final response = await http.post(
      Uri.parse('${Constants.url}/login'),
      headers: {
        'Authorization': 'Bearer $_token',
      },
    );
    if (response.statusCode == 200) {
      print(json.decode(response.body));
    } else {
      print(response.statusCode);
    }
  }
}
