class Game {
  final String name;
  final String year;
  final int minJogadores;
  final int maxJogadores;
  final int duration;
  final String description;
  final String mechanics;
  bool isExpansion;

  Game({
    required this.name,
    required this.year,
    required this.minJogadores,
    required this.maxJogadores,
    required this.duration,
    required this.description,
    required this.mechanics,
    this.isExpansion = false,
  });
}