import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste1/models/jogo.dart';

class JogoService {
  final String baseUrl = 'http://localhost:3000/partidas';
  late final http.Client client;

  JogoService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Jogo>> fetchJogos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map<Jogo>((item) => Jogo.fromJson(item)).toList();
    } else {
      throw Exception('Erro ao carregar partidas');
    }
  }

  Future<List<Jogo>> fetchJogosFinalizados() async {
    final response = await client.get(Uri.parse('http://localhost:3000/jogos'));
    List<Jogo> todosJogos = await fetchJogos();
    return todosJogos.where((jogo) => jogo.finalizado == true).toList();
  }

  Future<void> saveJogo(Jogo jogo) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(jogo.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Erro ao salvar a partida');
    }
  }

  Future<void> updateJogo(Jogo jogo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${jogo.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(jogo.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar a partida');
    }
  }

  Future<void> deleteJogo(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Erro ao excluir a partida');
    }
  }

  Future<void> editarNomesEquipes(
      Jogo jogo, String novoNomeEquipe1, String novoNomeEquipe2) async {
    jogo.equipe1.nome = novoNomeEquipe1;
    jogo.equipe2.nome = novoNomeEquipe2;

    final response = await http.put(
      Uri.parse('$baseUrl/${jogo.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(jogo.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao editar os nomes das equipes');
    }
  }
}
