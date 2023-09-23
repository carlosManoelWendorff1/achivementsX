import 'package:flutter/material.dart';

import '../Models/game.dart';
import '../widgets/game_panel.dart';

class GameListPage extends StatelessWidget {
  final List<Game> games;

  GameListPage({required this.games});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Jogos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 painéis por linha
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 76.0,
              ),
              shrinkWrap: true, // Allow the GridView to take as much height as it needs
              
              itemCount: games.length,
              itemBuilder: (context, index) {
                return GamePanel(game: games[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
