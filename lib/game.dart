import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/sprites/background.dart';
import 'package:flappy_bird/sprites/ground.dart';
import 'package:flutter/material.dart';

import 'sprites/bird.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  // COMPONENTS OF THE GAME
  // - Background
  // - Bird
  // - Ground

  late Bird bird;
  late Background background;
  late Ground ground;

  // ON LOAD -> called when the game is loaded
  @override
  FutureOr<void> onLoad() {
    // add background
    background = Background(size);
    add(background);

    // add ground
    ground = Ground();
    add(ground);

    // add bird sprite
    bird = Bird();
    add(bird);
  }

  // ONTAP -> called when screen is tapped
  @override
  void onTap() {
    bird.flap();
  }

  // GAME OVER
  bool isGameOver = false;

  void gameOver() {
    // prevent multiple "game over"s
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    showDialog(
      context: buildContext!,
      builder: (buildContext) => AlertDialog(
        content: Text("Game Over"),
        actions: [
          TextButton(
            onPressed: () {
              restartGame();
            },
            child: Text("Restart"),
          ),
        ],
      ),
    );
  }

  void restartGame() {
    // close the dialog
    Navigator.pop(buildContext!);

    bird.reset();
    isGameOver = false;
    resumeEngine();
  }
}
