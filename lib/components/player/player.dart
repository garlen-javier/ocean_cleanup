import 'dart:async';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:ocean_cleanup/bloc/player_stats/player_stats_barrel.dart';
import 'package:ocean_cleanup/constants.dart';
import 'package:ocean_cleanup/mixins/update_mixin.dart';
import 'package:ocean_cleanup/utils/math_utils.dart';
import '../../scenes/game_scene.dart';
import '../../worlds/game_world.dart';
import '../trash/trash.dart';

enum PlayerAnimationState {
  idle,
  running,
  catching,
}

class Player extends SpriteAnimationGroupComponent with UpdateMixin,CollisionCallbacks,HasGameRef<GameScene>{

  Vector2 pos;
  Vector2? scaleFactor;
  PlayerStatsBloc statsBloc;

  Player(this.pos,{this.scaleFactor,required this.statsBloc}):super(){
    scale = scaleFactor ?? Vector2.all(1);
  }

  Vector2 _velocity = Vector2.zero();
  double _speed = 150;
  List<Trash> trashCache = [];

  @override
  Future<void> onLoad() async {
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
    position = pos;

    animationTickers?[PlayerAnimationState.catching]?.onComplete = () {
      current = PlayerAnimationState.idle;
    };

    add(RectangleHitbox(size:size,isSolid: true));
    priority = playerPriority;
    return super.onLoad();
  }

  // @override
  // void update(double dt) {
  //   super.update(dt);
  //   position+=_velocity * _speed * dt;
  //   position.clamp(Vector2(width * 0.5 ,height* 0.5), Vector2(GameWorld.bounds.width - (width* 0.5) ,  GameWorld.bounds.height - (height* 0.5)));
  // }


  @override
  void runUpdate(double dt) {
    position+=_velocity * _speed * dt;
    position.clamp(Vector2(width * 0.5 ,height* 0.5), Vector2(GameWorld.bounds.width - (width* 0.5) ,  GameWorld.bounds.height - (height* 0.5)));
  }

  void updateDirection(Vector2 pVelocity,double pAngle) {
    _velocity = pVelocity;
    _flipSpriteByDirection(pVelocity);
    _updateAnimationByDirection(pVelocity);
    if(pVelocity != Vector2.zero()) {
      double degree = MathUtils.radToDeg(pAngle) - 90;
      angle = MathUtils.degToRad(degree);
    }
  }

  void playCatchAnimation()
  {
   current = PlayerAnimationState.catching;
  }

  void _updateAnimationByDirection(Vector2 dir)
  {
    if(dir == Vector2.zero()) {
      current = PlayerAnimationState.idle;
    }
    else{
      if(current != PlayerAnimationState.running)
        current = PlayerAnimationState.running;
    }
  }

  void _flipSpriteByDirection(Vector2 dir)
  {
    if(dir.x < 0 && !isFlippedVertically) {
      flipVertically();
    }
    else if (dir.x > 0 && isFlippedVertically) {
      flipVertically();
    }
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Trash) {
      Trash trash = other;
      trashCache.add(trash);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Trash) {
      Trash trash = other;
      if(trashCache.contains(trash))
        trashCache.remove(trash);
    }
  }

  void tryRemoveTrash()
  {
    if(trashCache.isNotEmpty)
    {
      Trash trash = trashCache.last;
      statsBloc.addTrash(trash.type);
      trash.removeFromParent();
      trashCache.removeLast();
      //statsBloc.addTrash(trash.type);
    }
  }


}