import 'package:flutter/material.dart';
import '../models/jogo.dart';
import '../models/equipe.dart';
import 'contador_de_pontos_screen.dart';

class AdicionarJogoScreen extends StatefulWidget {
  final List<Jogo> jogos;
  final Function(Jogo) onJogoAdicionado;

  AdicionarJogoScreen({required this.jogos, required this.onJogoAdicionado});

  @override
  _AdicionarJogoScreenState createState() => _AdicionarJogoScreenState();
}

class _AdicionarJogoScreenState extends State<AdicionarJogoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _equipe1Controller = TextEditingController();
  final _equipe2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      appBar: AppBar(
        title: Text('Adicionar Jogo'),
        centerTitle: true,
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Configurar Equipes',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _equipe1Controller,
                decoration: InputDecoration(
                  labelText: 'Nome da Equipe 1',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da equipe';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _equipe2Controller,
                decoration: InputDecoration(
                  labelText: 'Nome da Equipe 2',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da equipe';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                icon: Icon(Icons.add, color: Colors.white),
                label: Text('Adicionar Jogo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  textStyle: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final novoJogo = Jogo(
                      equipe1: Equipe(nome: _equipe1Controller.text),
                      equipe2: Equipe(nome: _equipe2Controller.text),
                    );
                    _navegarParaContador(novoJogo);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navegarParaContador(Jogo jogo) async {
    final jogoFinalizado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContadorPontosScreen(jogo: jogo)),
    );
    if (jogoFinalizado != null && jogoFinalizado.finalizado) {
      setState(() {
        widget.onJogoAdicionado(jogoFinalizado);
      });
      Navigator.pop(context);
    }
  }
}
