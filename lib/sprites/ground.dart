import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/game.dart';

import '../contants.dart';

class Ground extends SpriteComponent
    with HasGameReference<FlappyBirdGame>, CollisionCallbacks {
  Ground() : super();

  @override
  FutureOr<void> onLoad() async {
    // set size & position
    size = Vector2(game.size.x * 2, groundHeight);
    position = Vector2(0, game.size.y - 200);

    // load the sprite
    sprite = await Sprite.load('ground.png');

    // add hitbox
    add(RectangleHitbox());
  }

  // UPDATE -> move the ground to the left
  @override
  void update(double dt) {
    position.x -= groundScrollSpeed * dt;

    // reset ground after half of it goes off screen
    if (position.x + size.x / 2 <= 0) {
      position.x = 0;
    }
  }
}
