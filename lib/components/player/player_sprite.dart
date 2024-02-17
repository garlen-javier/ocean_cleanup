import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import '../../scenes/game_scene.dart';

enum PlayerAnimationState {
  idle,
  running,
}

class PlayerSprite extends SpriteAnimationGroupComponent with HasGameRef<GameScene>  {

  PlayerSprite() :super();

  @override
  FutureOr<void> onLoad() async {

    final spritesheet = SpriteSheet(
        image: gameRef.images.fromCache("sprite2.png"),
        srcSize: Vector2(58,80)
    );

    final idle = spritesheet.createAnimation(row:8,stepTime: 0.2,);
    final running = spritesheet.createAnimation(row:1,stepTime: 0.2,);

    animations = {
      PlayerAnimationState.running: running,
      PlayerAnimationState.idle: idle,
    };

    current = PlayerAnimationState.idle;
    anchor = Anchor.center;
    scale = Vector2.all(0.5);

    priority = 2;
    debugMode = true;
    return super.onLoad( );
  }

}




