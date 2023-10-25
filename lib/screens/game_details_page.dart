import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:x_axhievments/Models/game.dart';

class GameDetailScreen extends StatelessWidget {

  final storage = FirebaseStorage;
  final Game game;

  GameDetailScreen({required this.game});

  @override
  Widget build(BuildContext context) {
    final firebaseStorageURL = 'https://firebasestorage.googleapis.com/v0/b/xachievments.appspot.com/o/${game.imageAsset}?alt=media';
    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.network(
                firebaseStorageURL, // Replace with the actual Firebase Storage image URL
                height: 300.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16.0),
              Text(
                game.name,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // Center the text horizontally
              ),
              SizedBox(height: 8.0),
              Text(
                game.description,
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center, // Center the text horizontally
              ),
              Text(
                'Achievements:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              Expanded(
                child: ListView.builder(
                  itemCount: game.achievements.length,
                  itemBuilder: (context, index) {
                    final achievement = game.achievements[index];
                    final gradient = achievement.status
                        ? LinearGradient(
                            colors: [Colors.green.shade200, Colors.green.shade500],
                          )
                        : LinearGradient(
                            colors: [Colors.grey.shade200, Colors.grey.shade500],
                          );

                    return Container(
                      decoration: BoxDecoration(
                        gradient: gradient,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(
                          achievement.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: achievement.status
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          achievement.description,
                          style: TextStyle(
                            color: achievement.status
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        // You can customize the appearance of each achievement here
                      ),
                    );
                  },
                ),
              ),
              // Add more game details here as needed
            ],
          ),
        ),
      ),
    );
  }
}
