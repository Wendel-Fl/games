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
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 3, 17, 0.8392156862745098),
                  Color.fromRGBO(2, 3, 24, 0.788235294117647),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
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
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'EduNSWACTFoundation',
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
