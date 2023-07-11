import 'package:flutter/material.dart';
import 'package:games/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../model/game.dart';

class GameItem extends StatelessWidget {
  const GameItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        title: Text(game.nome),
        subtitle: Text('${game.ano}'),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(game.urlCapa),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.gameDetail,
            arguments: game,
          );
        },
      ),
    );
  }
}