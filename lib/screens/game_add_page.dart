import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:x_axhievments/Models/achievments.dart';

import '../Models/game.dart';

class GameEntryScreen extends StatefulWidget {
  @override
  _GameEntryScreenState createState() => _GameEntryScreenState();
}

class _GameEntryScreenState extends State<GameEntryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageAssetController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<Achievement> achievements = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Game'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Game Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a game name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: imageAssetController,
              decoration: InputDecoration(labelText: 'Image Asset URL'),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            Text(
              'Achievements',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildAchievementFields(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addAchievement,
              child: Text('Add Achievement'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementFields() {
    return Column(
      children: List.generate(achievements.length, (index) {
        return Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Achievement Name'),
              onChanged: (value) => achievements[index].setName(value)
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Achievement Description'),
              onChanged: (value) => achievements[index].setdescription(value),
            ),
            SwitchListTile(
              title: Text('Achievement Status'),
              value: achievements[index].status,
              onChanged: (value) {
                setState(() {
                  achievements[index].setstatus(value);
                });
              },
            ),
            Divider(),
          ],
        );
      }),
    );
  }

  void _addAchievement() {
    setState(() {
      achievements.add(Achievement(name: '', description: '', status: false));
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Create a Game object with the filled data
      Game newGame = Game(
        name: nameController.text,
        imageAsset: imageAssetController.text,
        description: descriptionController.text,
        achievements: achievements,
      );

      // Perform any action with the newGame object (e.g., save it to a database)
      final CollectionReference gamesCollection = FirebaseFirestore.instance.collection('games');

      try {
      // Add the game to Firestore
      await gamesCollection.add({
        'name': newGame.name,
        'imageAsset': newGame.imageAsset,
        'description': newGame.description,
        'achievements': newGame.achievements
            .map((achievement) => {
                  'name': achievement.name,
                  'description': achievement.description,
                  'status': achievement.status,
                })
            .toList(),
      });

      // Clear the form and navigate to the previous screen or perform any other action
      _formKey.currentState!.reset();
      nameController.clear();
      imageAssetController.clear();
      descriptionController.clear();
      setState(() {
        achievements.clear();
      });
    } catch (e) {
      // Handle any errors here, such as displaying an error message
      print('Error adding game to Firestore: $e');
    }
    }
  }
}

void main() => runApp(MaterialApp(home: GameEntryScreen()));
