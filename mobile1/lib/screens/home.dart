import 'package:flutter/material.dart';
import '../models/jogo.dart';

class HomeScreen extends StatelessWidget {
  final List<Jogo> jogos;
  final Function(Jogo) onJogosChanged;

  HomeScreen({required this.jogos, required this.onJogosChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      appBar: AppBar(
        title: Text('Contador de Truco'),
        centerTitle: true,
        backgroundColor: Colors.green[800],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu de Navegação',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Adicionar Jogo'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/add').then((_) {
                  onJogosChanged;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Jogos Finalizados'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/list');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo ao Contador de Truco!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              icon: Icon(Icons.add, color: Colors.white),
              label: Text('Adicionar Jogo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/add',
                ).then((_) {
                  onJogosChanged;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.list, color: Colors.white),
              label: Text('Jogos Finalizados'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/list',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
