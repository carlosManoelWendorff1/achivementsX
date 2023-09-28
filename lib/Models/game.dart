import 'package:x_axhievments/Models/achievments.dart';

class Game {
  final String name;
  final String imageAsset;
  final String description;
  final List<Achievement> achievements;

  Game({
    required this.name,
    required this.imageAsset,
    required this.description,
    required this.achievements
  });
}
