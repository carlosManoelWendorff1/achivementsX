import 'package:flutter/material.dart';

import '../Models/game.dart';
import '../widgets/game_panel.dart';

class GameListPage extends StatelessWidget {

  int _currentIndex = 1;

  final List<Game> games;

  GameListPage({required this.games});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
          onTap: (int index) {
          if (index == 2) {
            // Navigate to the /login route when "Settings" tab is tapped
            Navigator.of(context).pushNamed('/login');
          }
           if (index == 0) {
            // Navigate to the /login route when "Settings" tab is tapped
            Navigator.of(context).pushNamed('/profile');
          }
        },
        items: [
           BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'logout',
          ),
        ],
      ),
    );
    
  }  
  
}
