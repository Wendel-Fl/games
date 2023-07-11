import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../auth/auth.dart';

/*
  nome
  ano
  capa
*/

class GameOverviewPage extends StatelessWidget {
  const GameOverviewPage({super.key});

  Future fetch() async {
    // Auth auth = Provider.of(context);
    final url = 'http://206.189.206.44:8080/api/jogo?page=2';
    final response = await http.get(Uri.parse(url));
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
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
      body: const SingleChildScrollView(
        child: Card(child: Text('Jogos'),),
      ),
    );
  }
}
