import 'dart:async';

import 'package:flame/components.dart';
import 'package:flappy_bird/game.dart';

class Background extends SpriteComponent with HasGameReference<FlappyBirdGame> {
  // Initialize background position
  Background(Vector2 size) : super(position: Vector2(0, 0), size: size);

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('background.png');
  }
}
