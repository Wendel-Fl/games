import 'package:flutter/material.dart';

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

  Game({
    required this.id,
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
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      minimoJogadores: json['minimoJogadores'],
      maximoJogadores: json['maximoJogadores'],
      duracaoMedia: json['duracaoMedia'],
      ano: json['ano'],
      anoLancamentoNacional: json['anoLancamentoNacional'],
      mesLancamentoNacional: json['mesLancamentoNacional'],
      urlCapa: json['urlCapa'],
      expansao: json['expansao'],
    );
  }
}
