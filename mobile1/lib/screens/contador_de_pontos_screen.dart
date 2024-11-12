import 'package:flutter/material.dart';
import 'package:teste1/models/equipe.dart';
import 'package:teste1/services/jogo_service.dart';
import '../models/jogo.dart';

class ContadorPontosScreen extends StatefulWidget {
  final Jogo jogo;

  ContadorPontosScreen({required this.jogo});

  @override
  _ContadorPontosScreenState createState() => _ContadorPontosScreenState();
}

class _ContadorPontosScreenState extends State<ContadorPontosScreen> {
  int incremento = 1;
  final JogoService _jogoService = JogoService();

  void incrementarPontos(Equipe equipe) {
    if (widget.jogo.finalizado) return;

    setState(() {
      if (equipe.pontos < 12) {
        equipe.pontos += incremento;
        if (equipe.pontos >= 12) {
          equipe.pontos = 12;
          _finalizarPartida();
        }
      }
    });
  }

  void mudarParaTruco() {
    setState(() {
      incremento = 3;
    });
  }

  void voltarParaNormal() {
    setState(() {
      incremento = 1;
    });
  }

  Future<void> _finalizarPartida() async {
    setState(() {
      widget.jogo.finalizado = true;
    });

    await _jogoService.saveJogo(widget.jogo);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Partida Finalizada'),
          content: Text(
            '${widget.jogo.equipe1.nome}: ${widget.jogo.equipe1.pontos} \n'
            '${widget.jogo.equipe2.nome}: ${widget.jogo.equipe2.pontos}',
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      appBar: AppBar(
        title: Text('Contador de Pontos'),
        centerTitle: true,
        backgroundColor: Colors.green[800],
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Equipe 1
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.jogo.equipe1.nome,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${widget.jogo.equipe1.pontos}',
                        style: TextStyle(fontSize: 48, color: Colors.white),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                        ),
                        onPressed: () => incrementarPontos(widget.jogo.equipe1),
                        child: Text(
                          '+',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  width: 1.0,
                  color: Colors.white54,
                ),
                // Equipe 2
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.jogo.equipe2.nome,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${widget.jogo.equipe2.pontos}',
                        style: TextStyle(fontSize: 48, color: Colors.white),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                        ),
                        onPressed: () => incrementarPontos(widget.jogo.equipe2),
                        child: Text(
                          '+',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.sports_martial_arts, color: Colors.white),
                label: Text('Truco! (Contar 3 pontos)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                ),
                onPressed: mudarParaTruco,
              ),
              SizedBox(width: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.undo, color: Colors.white),
                label: Text('Voltar a Contar 1'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                ),
                onPressed: voltarParaNormal,
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
