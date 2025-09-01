import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/contants.dart';
import 'package:flappy_bird/game.dart';
import 'package:flappy_bird/sprites/pipe/pipe.dart';

import 'ground.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  // Initialize Bird position and size
  Bird()
    : super(
        position: Vector2(birdPositionX, birdPositionY),
        size: Vector2(birdWidth, birdHeight),
      );

  // LOAD BIRD SPRITE
  @override
  FutureOr<void> onLoad() async {
    // load sprite
    sprite = await Sprite.load('bird.png');

    // add hitbox
    add(RectangleHitbox());
  }

  // UPDATE -> updates the bird in some way every second
  @override
  void update(double dt) {
    // Apply gravity to the bird
    velocity += gravity * dt;

    // Update bird's position based on velocity
    position.y += velocity * dt;
  }

  // FLAP -> what happens after screen tap
  void flap() {
    velocity = jumpStrength;
  }

  // COLLISION DETECTION
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // if bird collides with ground
    if (other is Ground) {
      (parent as FlappyBirdGame).gameOver();
    }

    if (other is Pipe) {
      (parent as FlappyBirdGame).gameOver();
    }
  }

  // RESET -> after game over
  void reset() {
    position = Vector2(birdPositionX, birdPositionX);
    velocity = 0;
  }
}
