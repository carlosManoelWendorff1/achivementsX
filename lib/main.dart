import 'package:flutter/material.dart';

import 'Models/game.dart';
import 'screens/game_list_page.dart';
import 'screens/login_page.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final List<Game> games = [
      Game(
        name: 'Game 1',
        imageAsset: 'assets/images/test1.png', // Substitua pelo caminho da imagem
        description: 'Descrição do Jogo 1',
      ),
      Game(
        name: 'Game 2',
        imageAsset: 'assets/images/teste2.jpeg', // Substitua pelo caminho da imagem
        description: 'Descrição do Jogo 2',
      ),
      Game(
        name: 'Game 1',
        imageAsset: 'assets/images/test1.png', // Substitua pelo caminho da imagem
        description: 'Descrição do Jogo 1',
      ),
      Game(
        name: 'Game 2',
        imageAsset: 'assets/images/teste2.jpeg', // Substitua pelo caminho da imagem
        description: 'Descrição do Jogo 2',
      ),
      Game(
        name: 'Game 1',
        imageAsset: 'assets/images/test1.png', // Substitua pelo caminho da imagem
        description: 'Descrição do Jogo 1',
      ),
      Game(
        name: 'Game 2',
        imageAsset: 'assets/images/teste2.jpeg', // Substitua pelo caminho da imagem
        description: 'Descrição do Jogo 2',
      ),
      Game(
        name: 'Game 1',
        imageAsset: 'assets/images/test1.png', // Substitua pelo caminho da imagem
        description: 'Descrição do Jogo 1',
      ),
      Game(
        name: 'Game 2',
        imageAsset: 'assets/images/teste2.jpeg', // Substitua pelo caminho da imagem
        description: 'Descrição do Jogo 2',
      ),
      // Adicione mais jogos conforme necessário
    ];
    
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green, // Set the primary color to green
        brightness: Brightness.dark, // Use dark theme
      ),
      initialRoute: '/', // Specify the initial route
      routes: {
        '/': (context) => LoginPage(), // HomeScreen is the default route
        '/login': (context) => LoginPage(), // Add your login route
        '/gameList': (context) => GameListPage(games: games,), // Add your game list route
        // Add more routes as needed
      },
    );
  }
}


