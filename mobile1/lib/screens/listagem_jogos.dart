import 'package:flutter/material.dart';
import '../models/jogo.dart';
import '../services/jogo_service.dart';

class ListagemJogosScreen extends StatelessWidget {
  final JogoService _jogoService = JogoService();

  ListagemJogosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      appBar: AppBar(
        title: Text('Jogos Finalizados'),
        centerTitle: true,
        backgroundColor: Colors.green[800],
      ),
      body: FutureBuilder<List<Jogo>>(
        future: _jogoService.fetchJogosFinalizados(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(color: Colors.white));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar jogos finalizados',
                style: TextStyle(color: Colors.redAccent, fontSize: 18),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Nenhum jogo finalizado ainda',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          } else {
            final jogosFinalizados = snapshot.data!;
            return ListView.builder(
              itemCount: jogosFinalizados.length,
              itemBuilder: (context, index) {
                final jogo = jogosFinalizados[index];
                return Card(
                  color: Colors.green[800],
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      '${jogo.equipe1.nome} vs ${jogo.equipe2.nome}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      'Placar Final: ${jogo.equipe1.pontos} - ${jogo.equipe2.pontos}',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    leading: Icon(Icons.sports_esports, color: Colors.white),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            _editarNomesEquipes(context, jogo);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await _excluirJogo(context, jogo);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _editarNomesEquipes(BuildContext context, Jogo jogo) {
    final equipe1Controller = TextEditingController(text: jogo.equipe1.nome);
    final equipe2Controller = TextEditingController(text: jogo.equipe2.nome);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Nomes das Equipes'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: equipe1Controller,
                decoration: InputDecoration(labelText: 'Nome da Equipe 1'),
              ),
              TextFormField(
                controller: equipe2Controller,
                decoration: InputDecoration(labelText: 'Nome da Equipe 2'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await _jogoService.editarNomesEquipes(
                    jogo,
                    equipe1Controller.text,
                    equipe2Controller.text,
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Nomes das equipes atualizados')),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao atualizar nomes')),
                  );
                }
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _excluirJogo(BuildContext context, Jogo jogo) async {
    if (jogo.id != null) {
      try {
        await _jogoService.deleteJogo(jogo.id!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Jogo excluído com sucesso')),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ListagemJogosScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao excluir jogo')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ID do jogo inválido')),
      );
    }
  }
}
