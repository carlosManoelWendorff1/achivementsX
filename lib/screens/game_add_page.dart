import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
    ImagePicker _picker = ImagePicker();
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar jogo'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome do jogo'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Informe o nome do jogo';
                }
                return null;
              },
            ),
            // Modify TextFormField for Image Selection
        TextFormField(
        controller: imageAssetController,
        onTap: () async {
        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              setState(() {
                imageAssetController.text = pickedFile.path;
              });
            }
          },
          decoration: InputDecoration(labelText: 'Selecione a imagem'),
            readOnly: true, // So that the field can't be manually edited
           ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 20),
            Text(
              'Conquistas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildAchievementFields(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addAchievement,
              child: Text('Adicionar Conquista'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Criar jogo'),
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
      // Upload image to Firebase Storage
      Reference storageReference = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageReference.putFile(File(imageAssetController.text));
      String imageUrl = '';
      await uploadTask.whenComplete(() async {
        imageUrl = await storageReference.getDownloadURL();
      });
      Game newGame = Game(
        id: Random().toString(),
        name: nameController.text,
        imageAsset: imageUrl,
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
