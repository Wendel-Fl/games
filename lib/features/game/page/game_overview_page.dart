import 'package:flutter/material.dart';
import 'package:games/utils/app_routes.dart';
import 'package:provider/provider.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameController>(context, listen: false);
    final List<Game> loadGames = provider.games;
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogos'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
          )
        ],
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
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: loadGames.length,
                            itemBuilder: (ctx, index) =>
                                ChangeNotifierProvider.value(
                              value: loadGames[index],
                              child: Consumer<Game>(
                                builder: (ctx, game, _) => ListTile(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Theme.of(context).colorScheme.outline,
                                    ),
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                  ),
                                  title: Text(game.nome),
                                  subtitle: Text('$game'),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(game.urlCapa),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.gameDetail,
                                      arguments: game,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              provider.nextPage();
                            },
                            child: const Text('Carregar mais...'),
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
