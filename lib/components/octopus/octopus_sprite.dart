import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import '../../constants.dart';
import '../../scenes/game_scene.dart';

enum OctopusAnimationState {
  running,
}

class OctopusSprite extends SpriteAnimationGroupComponent with HasGameRef<GameScene>  {

  OctopusSprite() :super();

  @override
  FutureOr<void> onLoad() async {

    final spritesheet = SpriteSheet(
        image: gameRef.images.fromCache(pathShark),
        srcSize: Vector2(99,73)
    );

    final running = spritesheet.createAnimation(row:0,stepTime: 0.5);

    animations = {
      OctopusAnimationState.running: running,
    };

    current = OctopusAnimationState.running;
    anchor = Anchor.center;

    //debugMode = true;
    return super.onLoad( );
  }

}




