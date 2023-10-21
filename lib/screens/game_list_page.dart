import 'package:flutter/material.dart';
import 'package:x_axhievments/main.dart';

import '../Models/game.dart';
import '../widgets/game_panel.dart';

class GameListPage extends StatelessWidget {
  int _currentIndex = 1;

  final Future<List<Game>> games = getGames();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Game>>(
          future: games,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final games = snapshot.data;
              return SingleChildScrollView(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: games?.length,
                  itemBuilder: (context, index) {
                    return GamePanel(game: games![index]);
                  },
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          if (index == 2) {
            Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
          }
          if (index == 0) {
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
