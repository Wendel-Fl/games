import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:games/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState { idle, success, error, loading }

class AuthController with ChangeNotifier {
  String? _token;
  var state = AuthState.idle;
  // DateTime? _expiresIn;

  bool get isAuth {
    // final isValid = _expiresIn?.isAfter(DateTime.now()) ?? false;
    return _token != null /*&& isValid*/;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  Future<void> login(String email, String password) async {
    state = AuthState.loading;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));

    try {
      final response = await http.post(
        Uri.parse('${Constants.url}/login'),
        body: jsonEncode({'email': email, 'senha': password}),
        headers: {'Content-Type': 'application/json'},
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _token = response.body;
      await prefs.setString('token', '$_token');
      notifyListeners();
    } catch (e) {
      state = AuthState.error;
      notifyListeners();
    }
  }
}
