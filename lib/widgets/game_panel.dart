import 'package:flutter/material.dart';
import 'package:x_axhievments/screens/game_details_page.dart';
import '../Models/game.dart';

class GamePanel extends StatelessWidget {
  final Game game;

  GamePanel({required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to a new screen and pass the game information
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GameDetailScreen(game: game),
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            Container(
            decoration: 
            BoxDecoration(
              borderRadius: BorderRadius.circular(15.5)
            ),
            child:
            Image.asset(
              game.imageAsset,
              height: 250.0,
              width: double
                  .infinity, // Ensure the image covers the entire card width
              fit: BoxFit.fill,
            ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: LinearGradient(
                    colors: [Colors.green, Colors.green.withOpacity(0.1)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        game.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        game.description,
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
