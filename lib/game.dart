import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/sprites/background.dart';
import 'package:flappy_bird/sprites/ground.dart';
import 'package:flappy_bird/sprites/pipe/pipe.dart';
import 'package:flappy_bird/sprites/pipe/pipe_manager.dart';
import 'package:flutter/material.dart';

import 'sprites/bird.dart';
import 'sprites/score.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  // COMPONENTS OF THE GAME
  // - Background
  // - Bird
  // - Ground

  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late Score scoreText;

  // ON LOAD -> called when the game is loaded
  @override
  FutureOr<void> onLoad() {
    // add background
    background = Background(size);
    add(background);

    // add ground
    ground = Ground();
    add(ground);

    // add score
    scoreText = Score();
    add(scoreText);

    // add pipe manager
    pipeManager = PipeManager();
    add(pipeManager);

    // add bird sprite
    bird = Bird();
    add(bird);
  }

  // ONTAP -> called when screen is tapped
  @override
  void onTap() {
    bird.flap();
  }

  // Score
  int score = 0;

  void incrementScore() {
    score += 1;
  }

  // GAME OVER
  bool isGameOver = false;

  void gameOver() {
    // prevent multiple "game over"s
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    showDialog(
      barrierDismissible: false,
      context: buildContext!,
      builder: (buildContext) => AlertDialog(
        title: Text("Game Over"),
        content: Text("Your Final Score: $score"),

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

    // Reset the score
    score = 0;

    bird.reset();
    // Reset all Pipes
    children.whereType<Pipe>().forEach((pipe) => pipe.removeFromParent());
    isGameOver = false;
    resumeEngine();
  }
}
