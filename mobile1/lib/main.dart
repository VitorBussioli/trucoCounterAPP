import 'package:flutter/material.dart';
import 'screens/listagem_jogos.dart';
import 'screens/add_jogo_screen.dart';
import 'screens/home.dart';
import 'models/jogo.dart';

void main() {
  runApp(TrucoApp());
}

class TrucoApp extends StatefulWidget {
  @override
  _TrucoAppState createState() => _TrucoAppState();
}

class _TrucoAppState extends State<TrucoApp> {
  List<Jogo> jogos = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Contador de Truco',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(
                jogos: jogos,
                onJogosChanged: _atualizarJogos,
              ),
          '/list': (context) => ListagemJogosScreen(),
          '/add': (context) => AdicionarJogoScreen(
                jogos: jogos,
                onJogoAdicionado: _atualizarJogos,
              ),
        });
  }

  void _atualizarJogos(Jogo jogo) {
    setState(() {
      jogos.add(jogo);
    });
  }
}
