import 'package:flutter/material.dart';
import 'package:x_axhievments/Models/achievments.dart';
import 'package:x_axhievments/screens/profile_page.dart';
import 'package:x_axhievments/screens/register_page.dart';
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
      name: 'Super Adventure Quest',
      imageAsset: 'assets/images/test1.png',
      description: 'Embark on an epic adventure in a mystical world.',
      achievements: [
        Achievement(
          name: 'Novice Explorer',
          description: 'Discover your first hidden treasure.',
          status: true, // Example: Achievement is completed
        ),
        Achievement(
          name: 'Master of Swords',
          description: 'Defeat 100 enemies with your sword.',
          status: false, // Example: Achievement is not completed
        ),
      ],
    ),
    Game(
      name: 'Galactic Racer Pro',
      imageAsset: 'assets/images/teste2.jpeg',
      description: 'Race through the galaxy and become the ultimate champion.',
      achievements: [
        Achievement(
          name: 'Speed Demon',
          description: 'Achieve a top speed of 1000 mph in a race.',
          status: true, // Example: Achievement is completed
        ),
        Achievement(
          name: 'Galactic Explorer',
          description: 'Visit all 10 unique planets in the game.',
          status: true, // Example: Achievement is completed
        ),
        Achievement(
          name: 'Speed Demon',
          description: 'Achieve a top speed of 1000 mph in a race.',
          status: false, // Example: Achievement is not completed
        ),
        Achievement(
          name: 'Galactic Explorer',
          description: 'Visit all 10 unique planets in the game.',
          status: false, // Example: Achievement is not completed
        ),
        Achievement(
          name: 'Speed Demon',
          description: 'Achieve a top speed of 1000 mph in a race.',
          status: true, // Example: Achievement is completed
        ),
        Achievement(
          name: 'Galactic Explorer',
          description: 'Visit all 10 unique planets in the game.',
          status: false, // Example: Achievement is not completed
        ),
        Achievement(
          name: 'Speed Demon',
          description: 'Achieve a top speed of 1000 mph in a race.',
          status: true, // Example: Achievement is completed
        ),
        Achievement(
          name: 'Galactic Explorer',
          description: 'Visit all 10 unique planets in the game.',
          status: true, // Example: Achievement is completed
        ),
        Achievement(
          name: 'Speed Demon',
          description: 'Achieve a top speed of 1000 mph in a race.',
          status: false, // Example: Achievement is not completed
        ),
        Achievement(
          name: 'Galactic Explorer',
          description: 'Visit all 10 unique planets in the game.',
          status: false, // Example: Achievement is not completed
        ),
        Achievement(
          name: 'Speed Demon',
          description: 'Achieve a top speed of 1000 mph in a race.',
          status: true, // Example: Achievement is completed
        ),
        Achievement(
          name: 'Galactic Explorer',
          description: 'Visit all 10 unique planets in the game.',
          status: false, // Example: Achievement is not completed
        ),
      ],
    ),
    Game(
      name: 'Mystic Wizardry',
      imageAsset: 'assets/images/abner.jpg',
      description: 'Unleash your magical powers in a world of enchantment.',
      achievements: [
        Achievement(
          name: 'Apprentice Mage',
          description: 'Learn your first spell and cast it successfully.',
          status: true, // Example: Achievement is completed
        ),
        Achievement(
          name: 'Archmage',
          description: 'Master all 10 elemental spells in the game.',
          status: false, // Example: Achievement is not completed
        ),
      ],
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
        '/profile': (context) => ProfileScreen(),
        '/registration': (context) => RegisterPage()
        // Add more routes as needed
      },
    );
  }
}
