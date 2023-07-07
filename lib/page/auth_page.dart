import 'package:flutter/material.dart';

import '../components/auth_form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(1, 1, 10, 0.8549019607843137),
              /*gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 2, 12, 0.84),
                  Color.fromRGBO(6, 9, 38, 0.79),
                ],
              ),*/
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  margin: const EdgeInsets.only(bottom: 20.0),
                  /*decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(14, 15, 21, 0.1),
                  ),*/
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 45,
                      color: Theme.of(context)
                          .primaryTextTheme
                          .headlineSmall
                          ?.color,
                    ),
                  ),
                ),
                const AuthForm(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
