import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game.dart';

void main() {
  runApp(FlappyBird());
}

class FlappyBird extends StatelessWidget {
  const FlappyBird({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameWidget(game: FlappyBirdGame()),
    );
  }
}
