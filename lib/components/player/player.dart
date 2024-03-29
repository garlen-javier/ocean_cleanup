import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocean_cleanup/components/lightning.dart';
import 'package:ocean_cleanup/components/octopus/octopus.dart';
import 'package:ocean_cleanup/constants.dart';
import 'package:ocean_cleanup/core/audio_manager.dart';
import 'package:ocean_cleanup/mixins/update_mixin.dart';
import 'package:ocean_cleanup/utils/math_utils.dart';
import '../../bloc/game_stats/game_stats_barrel.dart';
import '../../core/game_scene.dart';
import '../../worlds/game_world.dart';
import '../shark/shark.dart';
import '../trash/trash.dart';

enum PlayerAnimationState {
  idle,
  running,
  catching,
}

class Player extends SpriteAnimationGroupComponent with UpdateMixin,CollisionCallbacks,HasGameRef<GameScene>{

  final GameStatsBloc statsBloc;
  double speed;

  Player({super.position,this.speed = 150,required this.statsBloc});

  Vector2 _velocity = Vector2.zero();
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

    animationTickers?[PlayerAnimationState.catching]?.onComplete = () {
      current = PlayerAnimationState.idle;
    };

     RectangleHitbox hitbox = RectangleHitbox(size:Vector2(width * 0.6,height * 0.65),position: Vector2(width * 0.3,0),isSolid: true );
     add(hitbox);
    //add(RectangleHitbox(size:size,isSolid: true));
    priority = playerPriority;
    //debugMode = true;
    return super.onLoad();
  }

  @override
  void runUpdate(double dt) {
    position+=_velocity * speed * dt;
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
      if(current != PlayerAnimationState.running && current != PlayerAnimationState.catching)
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
    if (other is Shark || other is Octopus) {
      _reduceHealth();
    }
    if (other is Lightning) {
      Lightning lightning = other;
      lightning.removeFromParent();
      _reduceHealth();
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

  void _reduceHealth()
  {
    statsBloc.reduceHealth(1);
    AudioManager.instance.playSfx(pathSfxReduceHealth);
  }

  void tryRemoveTrash()
  {
    if(trashCache.isNotEmpty)
    {
      Trash trash = trashCache.last;
      statsBloc.addTrash(trash.type!);
      trash.delete();
      trashCache.removeLast();
      AudioManager.instance.playSfx(pathSfxCatchTrash);
    }
    else{
      AudioManager.instance.playSfx(pathSfxSwingNet);
    }
  }

}