import 'package:flutter/material.dart';
import 'package:games/utils/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            title: const Text(
              'Logout',
              textAlign: TextAlign.center,
            ),
            content: const Text(
              'Deseja deslogar?',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'Não',
                  style: TextStyle(color: Colors.blueAccent),

                ),
              ),
              OutlinedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  if (context.mounted) {
                    Navigator.of(context).pushReplacementNamed(AppRoutes.auth);
                  }
                },
                child: const Text(
                  'Sim',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              )
            ],
          ),
        );
      },
      icon: const Icon(Icons.logout),
    );
  }
}
