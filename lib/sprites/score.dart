import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

import '../game.dart';

class Score extends TextComponent with HasGameReference<FlappyBirdGame> {
  Score()
    : super(
        text: '0',
        textRenderer: TextPaint(
          style: TextStyle(color: Colors.grey[900], fontSize: 48),
        ),
      );

  @override
  FutureOr<void> onLoad() {
    position = Vector2(
      // center horizontally
      (game.size.x - size.x) / 2,

      // slightly above bottom
      (game.size.y - size.y - 50),
    );
  }

  @override
  void update(double dt) {
    final newText = game.score.toString();

    if (text != newText) {
      text = newText;
    }
  }
}
