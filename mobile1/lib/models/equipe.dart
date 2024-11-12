class Equipe {
  String nome;
  int pontos;

  Equipe({required this.nome, this.pontos = 0});

  factory Equipe.fromJson(Map<String, dynamic> json) {
    return Equipe(
      nome: json['nome'],
      pontos: json['pontos'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'pontos': pontos,
    };
  }
}
