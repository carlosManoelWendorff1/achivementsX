import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:x_axhievments/Models/achievments.dart';
import 'package:x_axhievments/Models/game.dart';

void deleteAchievement(BuildContext context, Game game, int achievementIndex) {
  // Show a confirmation dialog for deleting the achievement
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Deletar Conquista?'),
        content: Text('Tem certeza que quer deletar esta conquista?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Deletar'),
            onPressed: () async {
              // Delete the achievement from the game's achievement list
              game.achievements.removeAt(achievementIndex);

              // Update the achievements in Firestore
              final gameCollection = FirebaseFirestore.instance.collection('games');
              await gameCollection.doc(game.id).update({
                'achievements': game.achievements
                    .map((achievement) => {
                          'name': achievement.name,
                          'description': achievement.description,
                          'status': achievement.status,
                        })
                    .toList(),
              });

              Navigator.of(context).pop(); // Close the dialog
              Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => GameDetailScreen(game: game),
              ),
          );
            },
          ),
        ],
      );
    },
  );
}

void updateAchievement(BuildContext context, Game game, int achievementIndex, String updatedName, String updatedDescription, bool updatedStatus) {
  // Show a dialog for updating the achievement
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final Achievement achievement = game.achievements[achievementIndex];
      updatedName = achievement.name;
      updatedDescription = achievement.description;
      updatedStatus = achievement.status;

      return AlertDialog(
        title: Text('Atualizar Conquista'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Atualizar os campos da conquista:'),
            TextFormField(
              initialValue: updatedName,
              onChanged: (value) {
                updatedName = value;
              },
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              initialValue: updatedDescription,
              onChanged: (value) {
                updatedDescription = value;
              },
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SwitchListTile(
              title: Text('Status da Conquista'),
              value: updatedStatus,
              onChanged: (value) {
                updatedStatus = value;
              },
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Atualizar'),
            onPressed: () async {
              final gameCollection = FirebaseFirestore.instance.collection('games');
              game.achievements[achievementIndex] = Achievement(
                name: updatedName,
                description: updatedDescription,
                status: updatedStatus,
              );
              await gameCollection.doc(game.id).update({
                'achievements': game.achievements
                    .map((achievement) => {
                          'name': achievement.name,
                          'description': achievement.description,
                          'status': achievement.status,
                        })
                    .toList(),
              });

              Navigator.of(context).pop(); // Close the dialog
              Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => GameDetailScreen(game: game),
              ),
          );}),
        ],
      );
    },
  );
}

void deleteGame(BuildContext context,Game game) {
    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deletar jogo?'),
          content: Text('Tem certeza que quer deletar o jogo?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Deletar'),
              onPressed: () async {

                // Example code for deleting a Firestore document
                final gameCollection = FirebaseFirestore.instance.collection('games');
                await gameCollection.doc(game.id).delete();
                //final storageReference = FirebaseStorage.instance.ref().child(game.imageAsset);
                //await storageReference.delete();

                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pushNamed('/gameList'); // Close the game detail screen
              },
            ),
          ],
        );
      },
    );
  }
  void updateGame(BuildContext context, Game game, String updatedName, String updatedDescription) {
  // Show a dialog for updating the game
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Atualizar Jogo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Atualizar os campos do jogo:'),
            TextFormField(
              initialValue: updatedName,
              onChanged: (value) {
                updatedName = value;
              },
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              initialValue: updatedDescription,
              onChanged: (value) {
                updatedDescription = value;
              },
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Atualizar'),
            onPressed: () async {
              final gameCollection = FirebaseFirestore.instance.collection('games');
              await gameCollection.doc(game.id).update({
                'name': updatedName,
                'description': updatedDescription,
              });

              Navigator.of(context).pop(); // Close the dialog
              Navigator.of(context).pushNamed('/gameList'); // Close the game detail screen
            },
          ),
        ],
      );
    },
  );
}


class GameDetailScreen extends StatelessWidget {
  final Game game;

  GameDetailScreen({required this.game});

  @override
  Widget build(BuildContext context) {
    final firebaseStorageURL = game.imageAsset;

    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        
        children: [
          FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              updateGame(context, game, game.name, game.description);
            },
            child: Icon(Icons.edit, color: Colors.white),
          ),
          SizedBox(width: 16.0), // Add spacing between the buttons
          FloatingActionButton(
            backgroundColor: Colors.red, // You can use another color like red for deleting
            onPressed: () {
              deleteGame(context, game);
            },
            child: Icon(Icons.delete, color: Colors.white),
          ),
          SizedBox(width: 16.0),
          FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              // Add your code to navigate to the screen for adding a new achievement
              // Navigator.of(context).pushNamed('/addAchievement');
            },
            child: Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.network(
                firebaseStorageURL,
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
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              Text(
                game.description,
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
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
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              color: achievement.status
                                ? Colors.white
                                : Colors.black,
                              onPressed: () {
                                
                                updateAchievement(context, game, index, achievement.name, achievement.description, achievement.status);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: achievement.status
                                ? Colors.white
                                : Colors.black,
                              onPressed: () {
                                // Delete the achievement
                                deleteAchievement(context, game, index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}