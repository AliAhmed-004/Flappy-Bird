import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/contants.dart';

import '../../game.dart';

class Pipe extends SpriteComponent
    with CollisionCallbacks, HasGameReference<FlappyBirdGame> {
  // determines if the pipe is top or bottom
  bool isTopPipe;

  // check if scored
  bool scored = false;

  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
    : super(position: position, size: size);

  // ONLOAD
  @override
  FutureOr<void> onLoad() async {
    // add hitbox
    add(RectangleHitbox());

    // load sprite
    sprite = await Sprite.load(isTopPipe ? 'pipe_top.png' : 'pipe_bottom.png');
  }

  // UPDATE
  @override
  void update(double dt) {
    // scroll the pipe left
    position.x -= groundScrollSpeed * dt;

    // increment score if top pipe moves behind bird
    if (!scored && position.x + size.x < game.bird.size.x) {
      scored = true;

      // only increment for one pipe to avoid double increments
      if (isTopPipe) {
        game.incrementScore();
      }
    }

    // remove pipe if it goes off screen
    if (size.x + position.x / 2 <= 0) {
      removeFromParent();
    }
  }
}
