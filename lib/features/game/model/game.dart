import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'caracteristica.dart';

class Game with ChangeNotifier {
  final int id;
  final String nome;
  final String descricao;
  final int minimoJogadores;
  final int maximoJogadores;
  final int duracaoMedia;
  final int ano;
  final String? anoLancamentoNacional;
  final String? mesLancamentoNacional;
  final String urlCapa;
  final bool expansao;
  final List<Caracteristica> caracteristicas;

  Game(
      {required this.id,
      required this.nome,
      required this.descricao,
      required this.minimoJogadores,
      required this.maximoJogadores,
      required this.duracaoMedia,
      required this.ano,
      this.anoLancamentoNacional,
      this.mesLancamentoNacional,
      required this.urlCapa,
      this.expansao = false,
      required this.caracteristicas});

  factory Game.fromJson(Map<String, dynamic> json) {
    final List<dynamic> caracteristicasJson = json['caracteristicas'];
    final caracteristicas = caracteristicasJson
        .map(
          (caracteristicaJson) => Caracteristica.fromJson(caracteristicaJson),
        )
        .toList();

    return Game(
      id: json['id'] ?? 0,
      nome: json['nome'],
      descricao: json['descricao'],
      minimoJogadores: json['minimoJogadores'],
      maximoJogadores: json['maximoJogadores'],
      duracaoMedia: json['duracaoMedia'] ?? 0,
      ano: json['ano'],
      anoLancamentoNacional: json['anoLancamentoNacional'],
      mesLancamentoNacional: json['mesLancamentoNacional'],
      urlCapa: json['urlCapa'] ?? '',
      expansao: json['expansao'],
      caracteristicas: caracteristicas ?? [],
    );
  }

  String getDescricao(Game game) {
    final mecanicas = game.caracteristicas
        .where((element) => element.tipo == 'MECANICA')
        .mapIndexed((index, e) => '• ${e.descricao}')
        .toList();

    return mecanicas.join('\n');
  }
}
