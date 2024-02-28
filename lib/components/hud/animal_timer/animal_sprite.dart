import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import '../../../constants.dart';
import '../../../levels/level_parameters.dart';
import '../../../scenes/game_scene.dart';

enum AnimalAnimationState {
  idle,
}

class AnimalSprite extends SpriteAnimationGroupComponent with HasGameRef<GameScene>  {

  final AnimalType type;
  AnimalSprite({required this.type,super.position});

  @override
  FutureOr<void> onLoad() async {

   var image = gameRef.images.fromCache(animalPathMap[type]!);
    final spritesheet = SpriteSheet(
        image: image,
        srcSize: Vector2(image.size.x/3,image.size.y)
    );

    final idle = spritesheet.createAnimation(row:0,stepTime: 0.5,);

    animations = {
      AnimalAnimationState.idle: idle,
    };

    current = AnimalAnimationState.idle;
    anchor = Anchor.center;
    flipHorizontally();
    //debugMode = true;
    return super.onLoad( );
  }

}




