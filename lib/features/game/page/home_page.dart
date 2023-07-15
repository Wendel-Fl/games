import 'package:flutter/material.dart';
import 'package:games/features/auth/components/logout_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/game_list.dart';
import '../controller/game_controller.dart';
import '../model/game.dart';

class GameOverviewPage extends StatefulWidget {
  const GameOverviewPage({super.key});

  @override
  State<GameOverviewPage> createState() => _GameOverviewPageState();
}

class _GameOverviewPageState extends State<GameOverviewPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<GameController>(
      context,
      listen: false,
    ).loadGames().then((value) {
      setState(() => _isLoading = false);
    });
    getCred();
  }

  void getCred() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.getString('token');
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameController = Provider.of<GameController>(context, listen: false);
    final List<Game> loadGames = gameController.games;
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogos'),
        centerTitle: true,
        actions: const [LogoutButton()],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SizedBox(
                    height: deviceSize.height * 0.75,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GameList(loadGames),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            child: ElevatedButton(
                              onPressed: () {
                                gameController.nextPage();
                              },
                              child: const Text('Carregar mais...'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
