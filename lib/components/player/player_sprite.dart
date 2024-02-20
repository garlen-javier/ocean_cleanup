import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import '../../constants.dart';
import '../../scenes/game_scene.dart';

enum PlayerAnimationState {
  idle,
  running,
  catching,
}

class PlayerSprite extends SpriteAnimationGroupComponent with HasGameRef<GameScene>  {

  PlayerSprite() :super();

  @override
  FutureOr<void> onLoad() async {

    final spritesheet = SpriteSheet(
        image: gameRef.images.fromCache(pathPlayer),
        srcSize: Vector2(112,102.3333333333333)
    );

    final idle = spritesheet.createAnimation(row:0,stepTime: 0.5,);
    final running = spritesheet.createAnimation(row:1,stepTime: 0.5,);
    final catching = spritesheet.createAnimation(row:2,stepTime: 0.5,loop:false);

    animations = {
      PlayerAnimationState.idle: idle,
      PlayerAnimationState.running: running,
      PlayerAnimationState.catching: catching,
    };

    current = PlayerAnimationState.idle;
    anchor = Anchor.center;

    animationTickers?[PlayerAnimationState.catching]?.onComplete = () {
      current = PlayerAnimationState.idle;
    };

    //debugMode = true;
    return super.onLoad( );
  }

}




