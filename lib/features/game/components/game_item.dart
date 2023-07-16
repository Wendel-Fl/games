import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_routes.dart';
import '../model/game.dart';

class GameItem extends StatelessWidget {
  const GameItem({super.key});

  // Future getGameId(BuildContext context) async {
  //
  //   final gameList = await Provider.of<GameController>(
  //     context,
  //     listen: false,
  //   ).loadGames(page);
  //
  //   for (var game in gameList) {
  //     final currentGame = game.id;
  //     if (context.mounted) {
  //       final gameId = Provider.of<GameController>(
  //         context,
  //         listen: false,
  //       ).loadCurrentGame(currentGame);
  //       return gameId;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: ListTile(
          title: Text(
            game.nome,
            style: Theme.of(context).textTheme.copyWith().bodySmall,
          ),
          subtitle: Text(
            '${game.ano}',
            style: Theme.of(context).textTheme.copyWith().bodySmall,
          ),
          leading: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: game.urlCapa,
            height: 50,
            width: 50,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.gameDetail,
              arguments: game,
            );
          },
        ),
      ),
    );
  }
}
