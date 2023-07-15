import 'package:flutter/material.dart';
import 'package:games/features/auth/page/auth_page.dart';
import 'package:games/features/game/page/home_page.dart';
import 'package:provider/provider.dart';

import 'features/auth/controller/auth_controller.dart';
import 'features/game/controller/game_controller.dart';
import 'features/game/page/game_detail_page.dart';
import 'page/auth_or_home_page.dart';
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
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProxyProvider<AuthController, GameController>(
          create: (_) => GameController('', []),
          update: (ctx, auth, previous) {
            return GameController(
              auth.token ?? '',
              previous?.games ?? [],
            );
          },
        ),
      ],
      child: MaterialApp(
        title: 'App Games',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromRGBO(11, 13, 54, 0.9019607843137255),
            secondary: Colors.lightBlue,
          ),
          // fontFamily: 'RobotoCondensed',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodySmall: const TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 17,
                ),
                titleSmall: const TextStyle(
                  fontFamily: 'EduNSWACTFoundation',
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                ),
                titleMedium: const TextStyle(
                  fontFamily: 'EduNSWACTFoundation',
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
                titleLarge: const TextStyle(
                  fontFamily: 'RubikMarkerHatch',
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
        ),
        routes: {
          AppRoutes.authOrHome: (ctx) => const AuthOrHomePage(),
          AppRoutes.auth: (ctx) => const AuthPage(),
          AppRoutes.home: (ctx) => const HomePage(),
          AppRoutes.gameDetail: (ctx) => const GameDetailPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
