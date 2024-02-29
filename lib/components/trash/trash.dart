import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/rendering.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:ocean_cleanup/components/brick/catcher_body.dart';
import 'package:ocean_cleanup/levels/level_parameters.dart';
import 'package:ocean_cleanup/worlds/game_world.dart';
import 'dart:async' as dartAsync;
import '../../constants.dart';
import '../../mixins/update_mixin.dart';
import '../../scenes/game_scene.dart';


class Trash extends SpriteComponent with UpdateMixin,CollisionCallbacks,HasGameRef<GameScene> {
  final Vector2 pos;
  final TrashType type;
  final int directionX;
  final double speed;

  Trash ({required this.pos,required this.type,this.speed = 0.5,this.directionX = 1});

  final double _amplitude = 0.5; // Adjust the amplitude of the wiggle
  final double _frequency = 5.0; // Adjust the frequency of the wiggle
  double _velocity = 0.0;

  @override
  Future<void> onLoad() async {
    sprite = Sprite(gameRef.images.fromCache(trashPathMap[type]!));
    anchor = Anchor.center;
    position = Vector2(pos.x + width * 0.5,pos.y - height * 0.5);

    add(RectangleHitbox(size:size));

    //debugMode = true;
    return super.onLoad();
  }

  @override
  void runUpdate(double dt) {
    double x = _velocity * directionX;
    double y = _amplitude * sin(_velocity * _frequency);

    position+=Vector2(x,y);
    _velocity += speed * dt;
    position.y.clamp(height* 0.5, GameWorld.bounds.height - (height* 0.5));
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is CatcherBody) {
        removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }


}