import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:ocean_cleanup/worlds/game_world.dart';
import 'dart:async' as dartAsync;

import '../../utils/math_utils.dart';
import 'trash_sprite.dart';


class Trash extends BodyComponent  {
  final Vector2 pos;

  Trash ({required this.pos});
  late TrashSprite sprite;

  final Random _random = Random();
  Vector2 _velocityDir = Vector2.zero();
  double _speed = 500;
  bool _isReverse = false;

  @override
  Future<void> onLoad() async {
    sprite = TrashSprite();
    await add(sprite);

    _initRandomMove();
    renderBody = false;
    return super.onLoad();
  }

  void _initRandomMove()
  {
    _randomizeDirection();
    add(
        TimerComponent(
          period: 3,
          repeat: true,
          onTick: () {
            if(_isPositionXValidMove && _isPositionYValidMove ) {
              _randomizeDirection();
            }
          },
        )
    );
  }

  void _randomizeDirection()
  {
     double angleDir = _random.nextDouble() * MathUtils.tau;
     _velocityDir = MathUtils.angleRadToDir(angleDir);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _tryReverseDirection();
    body.linearVelocity+= _velocityDir * _speed * dt;
    body.position.clamp(Vector2(sprite.width , sprite.height), Vector2(GameWorld.bounds.width - (sprite.width) ,  GameWorld.bounds.height - (sprite.height)));
  }

  void _tryReverseDirection()
  {
    if(!_isReverse && (_isPositionXOut || _isPositionYOut))
    {
      _velocityDir*=-1;
      _isReverse = true;
    }
    else if(_isReverse && !(_isPositionXOut || _isPositionYOut))
    {
      _isReverse = false;
    }
  }

  bool get _isPositionXOut => body.position.x < sprite.width || body.position.x > GameWorld.bounds.width - (sprite.width);
  bool get _isPositionYOut => body.position.y < sprite.height || body.position.y > GameWorld.bounds.height -(sprite.height);

  bool get _isPositionXValidMove => body.position.x > GameWorld.bounds.width * 0.3 && body.position.x < GameWorld.bounds.width * 0.8;
  bool get _isPositionYValidMove => body.position.y > GameWorld.bounds.height * 0.3 && body.position.y < GameWorld.bounds.height * 0.8;

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      userData: this,
      position: pos,
      gravityScale: Vector2.zero(),
      linearDamping: 3,
      fixedRotation: false,
    );

    final fixtureDef = FixtureDef(
      PolygonShape()..setAsBoxXY(sprite.width * 0.5,sprite.height * 0.5),
      isSensor: true,
    );

    final body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);
    return body;
  }


}