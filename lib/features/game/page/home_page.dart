import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/components/logout_button.dart';
import '../components/game_list.dart';
import '../controller/game_controller.dart';
import '../model/game.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isFirstLoadRunning = true;

  bool _hasNextPage = true;

  bool _isLoadMoreRunning = false;

  int _currentPage = 0;

  List<Game> _games = [];

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      List<Game> games = await Provider.of<GameController>(
        context,
        listen: false,
      ).loadGames(_currentPage);
      _games = games;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.copyWith().secondary,
          content: const Text('Não foi possível carregar a lista de jogos'),
        ),
      );
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      _currentPage++;

      try {
        List<Game> games = await Provider.of<GameController>(
          context,
          listen: false,
        ).loadGames(_currentPage);

        if (games.isNotEmpty) {
          _games.addAll(games);
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.copyWith().secondary,
            content: const Text(
              'Não foi possível carregar a próxima lista de jogos',
            ),
          ),
        );
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  void loadCurrentGame() async {
    List<Game> games = await Provider.of<GameController>(
      context,
      listen: false,
    ).loadGames(_currentPage);

    for (var game in games) {
      final gameId = game.id;
      if (context.mounted) {
        await Provider.of<GameController>(
          context,
          listen: false,
        ).loadCurrentGame(gameId);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jogos',
          style: Theme.of(context).textTheme.copyWith().titleLarge,
        ),
        centerTitle: true,
        actions: const [LogoutButton()],
      ),
      body: _isFirstLoadRunning
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GameList(_games),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _loadMore();
                            },
                            child: _hasNextPage == false
                                ? const ScaffoldMessenger(
                                    child: Text(
                                      'A lista de jogos está completa',
                                    ),
                                  )
                                : const Text(
                                    'Carregar mais...',
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
