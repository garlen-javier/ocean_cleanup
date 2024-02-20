
import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:ocean_cleanup/constants.dart';
import '../../scenes/game_scene.dart';


class TrashSprite extends SpriteComponent with HasGameRef<GameScene>   {

  TrashSprite() :super();

  @override
  FutureOr<void> onLoad() async {
    sprite = Sprite(gameRef.images.fromCache(pathBagTrash));
    anchor = Anchor.center;
    //debugMode = true;
    return super.onLoad( );
  }

}




