import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:ocean_cleanup/components/brick/catcher_body.dart';
import 'package:ocean_cleanup/levels/level_parameters.dart';
import 'dart:async' as dartAsync;
import '../../constants.dart';
import '../../framework/object_pool.dart';
import '../../mixins/update_mixin.dart';
import '../../scenes/game_scene.dart';
import '../../worlds/game_world.dart';


class Trash extends SpriteComponent with UpdateMixin,CollisionCallbacks,HasGameRef<GameScene> {

  double _amplitude = 0.5; // Adjust the amplitude of the wiggle
  double _frequency = 5.0; // Adjust the frequency of the wiggle
  double _velocity = 0.0;

  RectangleHitbox? _hitBox;
  TrashType? type;
  ObjectPool<Trash>? _pool;
  Vector2 _pos = Vector2.zero();
  int _directionX = 1;
  double _speed = 0.5;

  @override
  void onMount() {
    if(type == TrashType.any)
      throw Exception("No available trash path for TrashType.any");

    sprite = Sprite(gameRef.images.fromCache(trashPathMap[type]!));
    anchor = Anchor.center;
    position = Vector2(_pos.x + width * 0.5,_pos.y - height * 0.5);

    if(_hitBox == null)
      add(_hitBox = RectangleHitbox(size:size));
    //debugMode = true;
    super.onMount();
  }

  void setup({
    required Vector2 pos,
    required TrashType trashType,
    double speed = 0.5,
    int directionX = 1,
    required ObjectPool<Trash> trashPool})
  {
    _pos = pos;
    type =  trashType;
    _speed = speed;
    _directionX = directionX;
    _pool = trashPool;
    _reInitValues();
  }

  void _reInitValues()
  {
    _amplitude = 0.5;
    _frequency = 5.0;
    _velocity = 0.0;
  }

  @override
  void runUpdate(double dt) {
    double x = _velocity * _directionX;
    double y = _amplitude * sin(_velocity * _frequency);

    position+=Vector2(x,y);
    _velocity += _speed * dt;
    position.y.clamp(height* 0.5, GameWorld.bounds.height - (height* 0.5));
  }

  void _removeHitBox()
  {
    _hitBox?.removeFromParent();
    _hitBox = null;
  }

  void delete()
  {
    _removeHitBox();
    _pool?.returnObjectToPool(this);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is CatcherBody) {
      delete();
    }
    super.onCollisionStart(intersectionPoints, other);
  }


}