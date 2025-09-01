import 'dart:async';

import 'package:flame/components.dart';

class Background extends SpriteComponent {
  // Initialize background position
  Background(Vector2 size) : super(position: Vector2(0, 0), size: size);

  @override
  FutureOr<void> onLoad() async {
    // load sprite
    sprite = await Sprite.load('background.png');
  }
}
