import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:games/features/auth/components/logout_button.dart';
import '../model/game.dart';

class GameDetailPage extends StatefulWidget {
  const GameDetailPage({super.key});

  @override
  State<GameDetailPage> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  @override
  Widget build(BuildContext context) {
    final game = ModalRoute.of(context)!.settings.arguments as Game;
    // Stateful:
    //   final gameId = ModalRoute.of(context)!.settings.arguments as int;
    //   final gameCurrent = Provider.of<GameController>(
    //     context,
    //     listen: false,
    //   );
    //
    //   Game? game;
    //
    //   gameCurrent.loadCurrentGame(gameId).then((dynamic value) {
    //     if (value is Game) {
    //       setState(() {
    //         game = value;
    //       });
    //     } else {
    //       setState(() {
    //         game = null;
    //       });
    //     }
    //   });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            game.nome,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(),
          ),
        ),
        actions: const [LogoutButton()],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: ImageNetwork(
                        image: game.urlCapa,
                        height: 120,
                        width: 120,
                        onPointer: true,
                        debugPrint: false,
                        fullScreen: false,
                        fitAndroidIos: BoxFit.cover,
                        fitWeb: BoxFitWeb.cover,
                        onLoading: const CircularProgressIndicator(
                          color: Colors.indigoAccent,
                        ),
                        onError: const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            game.nome,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.calendar_month_outlined),
                              Text(
                                ' ${game.ano}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.people_alt_rounded),
                              Text(
                                ' ${game.minimoJogadores} a ${game.maximoJogadores} jogadores',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.hourglass_top_outlined),
                              Text(
                                ' ${game.duracaoMedia} min',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descrição do jogo',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(),
                  ),
                  Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        game.descricao,
                        textAlign: TextAlign.justify,
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, bottom: 15),
                child: game.getDescricao(game).isEmpty
                    ? Text(
                        'Sem Mecânicas',
                        style:
                            Theme.of(context).textTheme.titleSmall?.copyWith(),
                      )
                    : Column(
                        children: [
                          Text(
                            'Mecânicas',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(),
                          ),
                          Card(
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Text(
                                game.getDescricao(game),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(),
                              ),
                            ),
                          )
                        ],
                      ),
              ),
              game.expansao == true
                  ? Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.info_outline),
                          Text(
                            ' Este é um jogo do tipo expansão',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(),
                          )
                        ],
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
