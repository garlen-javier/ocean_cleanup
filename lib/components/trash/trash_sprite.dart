
import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import '../../scenes/game_scene.dart';


class TrashSprite extends SpriteAnimationGroupComponent with HasGameRef<GameScene>  {

  final Vector2 spriteSize = Vector2(26,64);
  //final Vector2 spriteSize = Vector2(190.5,385);
  TrashSprite() :super();

  @override
  FutureOr<void> onLoad() async {
    final spritesheet = SpriteSheet(
        image: gameRef.images.fromCache("recycle_items.png"),
     // image: await gameRef.images.load("Seahorsespritesheet.png"),
        srcSize: spriteSize
    );

    final trashSprite = SpriteComponent(
      sprite: spritesheet.getSprite(0, 1),
    );


    scale = Vector2.all(0.8);
    anchor = Anchor.center;
    priority = 1;
    size = spriteSize;
    
    add(trashSprite);
    debugMode = true;
    return super.onLoad( );
  }

}




