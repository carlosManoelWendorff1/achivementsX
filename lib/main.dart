import 'package:flutter/material.dart';
import 'package:x_axhievments/Models/achievments.dart';
import 'package:x_axhievments/screens/profile_page.dart';
import 'package:x_axhievments/screens/register_page.dart';
import 'Models/game.dart';
import 'screens/game_list_page.dart';
import 'screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final CollectionReference gamesCollection = FirebaseFirestore.instance.collection('games');

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

 // for (Game game in games) {
 //     await gamesCollection.add({
 //       'name': game.name,
 //       'imageAsset': game.imageAsset,
 //       'description': game.description,
 //       'achievements': game.achievements.map((ach) => {
 //         'name': ach.name,
 //         'description': ach.description,
 //         'status': ach.status,
 //       }).toList(),
 //     });
 // }  
  runApp(MyApp());
}



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

Future<List<Game>> getGames() async {
    final CollectionReference gamesCollection =
        FirebaseFirestore.instance.collection('games');
    QuerySnapshot gameDocuments = await gamesCollection.get();
    List<Game> games = gameDocuments.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      return Game(
        name: data['name'],
        imageAsset: data['imageAsset'],
        description: data['description'],
        achievements: (data['achievements'] as List).map((ach) {
        return Achievement(
          name: ach['name'],
          description: ach['description'],
          status: ach['status'],
        );
      }).toList());
    }).toList();
    return games;
  }

class _MyAppState extends State<MyApp> {
 

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
        '/gameList': (context) => GameListPage(),
        '/profile': (context) => ProfileScreen(),
        '/registration': (context) => SignUpPage()
        // Add more routes as needed
      },
    );
  }
}
