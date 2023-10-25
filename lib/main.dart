import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:x_axhievments/Models/achievments.dart';
import 'package:x_axhievments/screens/profile_page.dart';
import 'package:x_axhievments/screens/register_page.dart';
import 'Models/game.dart';
import 'screens/game_add_page.dart';
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

  final List<Game> games = [];


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
        '/gameAdd': (context) => GameEntryScreen(),
        '/profile': (context) => ProfileScreen(),
        '/registration': (context) => SignUpPage()
        // Add more routes as needed
      },
    );
  }
}
