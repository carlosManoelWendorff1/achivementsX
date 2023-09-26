import 'package:flutter/material.dart';
import 'package:x_axhievments/screens/profile_page.dart';
import 'Models/game.dart';
import 'screens/game_list_page.dart';
import 'screens/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Game> games = [
    Game(
      name: 'Game 1',
      imageAsset: 'assets/images/test1.png',
      description: 'Descrição do Jogo 1',
    ),
    Game(
      name: 'Game 2',
      imageAsset: 'assets/images/teste2.jpeg',
      description: 'Descrição do Jogo 2',
    ),
    Game(
      name: 'Game 1',
      imageAsset: 'assets/images/test1.png',
      description: 'Descrição do Jogo 1',
    ),
    Game(
      name: 'Game 2',
      imageAsset: 'assets/images/teste2.jpeg',
      description: 'Descrição do Jogo 2',
    ),
    Game(
      name: 'Game 1',
      imageAsset: 'assets/images/test1.png',
      description: 'Descrição do Jogo 1',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        brightness: Brightness.dark,
        iconTheme: IconThemeData(
          color: Colors.green, // Set the default icon color to green
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/login': (context) => LoginPage(),
        '/gameList': (context) => GameListPage(games: games),
        '/profile': (context) => ProfileScreen()
        // Add more routes as needed
      },
    );
  }
}
