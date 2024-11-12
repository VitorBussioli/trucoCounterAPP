import 'package:teste1/models/equipe.dart';

class Jogo {
  final String? id;
  final Equipe equipe1;
  final Equipe equipe2;
  bool finalizado;

  Jogo({
    this.id,
    required this.equipe1,
    required this.equipe2,
    this.finalizado = false,
  });

  factory Jogo.fromJson(Map<String, dynamic> json) {
    return Jogo(
      id: json['id'],
      equipe1: Equipe.fromJson(json['equipe1']),
      equipe2: Equipe.fromJson(json['equipe2']),
      finalizado: json['finalizado'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'equipe1': equipe1.toJson(),
      'equipe2': equipe2.toJson(),
      'finalizado': finalizado,
    };
    return data;
  }
}
