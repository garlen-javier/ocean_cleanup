
import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import '../../scenes/game_scene.dart';


class TrashSprite extends SpriteAnimationGroupComponent with HasGameRef<GameScene>  {

  final Vector2 pos;
  TrashSprite(this.pos) :super();

  @override
  FutureOr<void> onLoad() async {
    final spritesheet = SpriteSheet(
        image: gameRef.images.fromCache("recycle_items.png"),
        srcSize: Vector2(26,64)
    );

    final trashSprite = SpriteComponent(
      sprite: spritesheet.getSprite(0, 1),
      position: pos,
      anchor: Anchor.center,
      scale: Vector2.all(0.8),
      priority: 1
    );

    add(trashSprite);
    //debugMode = true;
    return super.onLoad( );
  }

}




