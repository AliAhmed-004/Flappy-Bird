import 'dart:math';

import 'package:flame/components.dart';

import '../../contants.dart';
import '../../game.dart';
import 'pipe.dart';

class PipeManager extends Component with HasGameReference<FlappyBirdGame> {
  double pipeSpawnTimer = 0;

  @override
  void update(double dt) {
    // Generates pipe at given interval
    pipeSpawnTimer += dt;

    if (pipeSpawnTimer > pipeInterval) {
      pipeSpawnTimer = 0;

      spawnPipe();
    }
  }

  void spawnPipe() {
    final double screenHeight = game.size.y;

    // CALCULATE STUFF
    final double maxPipeHeight =
        screenHeight - groundHeight - minPipeHeight - pipeGap;

    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);

    final double topPipeHeight =
        screenHeight - minPipeHeight - pipeGap - bottomPipeHeight;

    // Create Bottom Pipe
    final bottomPipe = Pipe(
      // position
      Vector2(game.size.x, screenHeight - groundHeight - bottomPipeHeight),
      // size
      Vector2(pipeWidth, bottomPipeHeight),
      isTopPipe: false,
    );

    // Create Bottom Pipe
    final topPipe = Pipe(
      // position
      Vector2(game.size.x, 0),
      // size
      Vector2(pipeWidth, topPipeHeight),
      isTopPipe: true,
    );

    // Add the pipes to the game
    game.add(topPipe);
    game.add(bottomPipe);
  }
}
