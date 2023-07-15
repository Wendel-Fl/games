class Caracteristica {
  final String tipo;
  final String descricao;

  Caracteristica({
    required this.tipo,
    required this.descricao,
  });

  factory Caracteristica.fromJson(Map<String, dynamic> json) {
    return Caracteristica(
      tipo: json['tipo'],
      descricao: json['descricao'],
    );
  }
}
