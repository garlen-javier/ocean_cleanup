import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';
import 'package:ocean_cleanup/mixins/update_mixin.dart';
import 'package:ocean_cleanup/worlds/game_world.dart';
import 'dart:async' as dartAsync;
import '../../constants.dart';
import '../../scenes/game_scene.dart';
import '../../utils/math_utils.dart';
import '../brick/catcher_body.dart';

enum SharkAnimationState {
  running,
}

class Shark extends SpriteAnimationGroupComponent with UpdateMixin, CollisionCallbacks, HasGameRef<GameScene>   {

  final Vector2 pos;
  final double directionX;
  final List<Vector2> sharkPoints;
  Shark ({required this.pos,required this.sharkPoints, this.directionX = 1});

  Random _rng = Random();
  Vector2 _velocityDir = Vector2.zero();
  double _speed = 100;

  @override
  Future<void> onLoad() async {
    final spritesheet = SpriteSheet(
        image: gameRef.images.fromCache(pathShark),
        srcSize: Vector2(99,73)
    );

    final running = spritesheet.createAnimation(row:0,stepTime: 0.5);

    animations = {
      SharkAnimationState.running: running,
    };

    current = SharkAnimationState.running;
    anchor = Anchor.center;
    position = Vector2(pos.x + width * 0.5,pos.y - height * 0.5);

    _velocityDir.x = directionX;
    _flipSpriteByXDirection(_velocityDir.x);

    RectangleHitbox hitbox = RectangleHitbox(size:Vector2(width * 0.8,height * 0.7),position: Vector2(width * 0.1,height * 0.15) );
    add(hitbox);
    //debugMode = true;
    return super.onLoad();
  }

  @override
  void runUpdate(double dt) {
    position += _velocityDir * _speed * dt;
    position.y.clamp(height * 0.5, GameWorld.bounds.height - (height * 0.5));
  }

  void setPosition(Vector2 pos)
  {
     position = Vector2(pos.x + width * 0.5,pos.y - height * 0.5);
  }

  void _flipSpriteByXDirection(double xDir)
  {
    if( xDir < 0 && !isFlippedHorizontally) {
      flipHorizontally();
    }
    else if ( xDir > 0 && isFlippedHorizontally) {
      flipHorizontally();
    }
  }

  void _updateFaceMovement()
  {
    if(isFlippedHorizontally)
      _velocityDir.x = -1;
    else
      _velocityDir.x = 1;
  }


  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is CatcherBody) {
      _randomizeSpawn();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void _randomizeSpawn()
  {
    int rand = _rng.nextInt(sharkPoints.length);
    Vector2 pos = sharkPoints[rand];
    setPosition(pos);
    _flipSpriteByXDirection(-pos.x.sign);
    _updateFaceMovement();
  }

}