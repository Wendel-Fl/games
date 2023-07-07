import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/auth.dart';
import 'page/auth_page.dart';
import 'page/game_overview_page.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromRGBO(11, 13, 54, 0.9019607843137255),
            secondary: Colors.deepOrange,
          ),
        ),
        routes: {
          AppRoutes.auth: (ctx) => const AuthPage(),
          AppRoutes.gameOverview: (ctx) => const GameOverviewPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
