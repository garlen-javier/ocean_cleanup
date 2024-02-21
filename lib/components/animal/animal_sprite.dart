import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import '../../constants.dart';
import '../../scenes/game_scene.dart';

enum AnimalAnimationState {
  idle,
}

class AnimalSprite extends SpriteAnimationGroupComponent with HasGameRef<GameScene>  {

  AnimalSprite() :super();

  @override
  FutureOr<void> onLoad() async {

    final spritesheet = SpriteSheet(
        image: gameRef.images.fromCache(pathDolphin),
        srcSize: Vector2(70,34)
    );

    final idle = spritesheet.createAnimation(row:0,stepTime: 0.5,);

    animations = {
      AnimalAnimationState.idle: idle,
    };

    current =AnimalAnimationState.idle;
    anchor = Anchor.center;

    //debugMode = true;
    return super.onLoad( );
  }

}




