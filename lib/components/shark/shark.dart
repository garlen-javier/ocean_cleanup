import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:ocean_cleanup/worlds/game_world.dart';
import 'dart:async' as dartAsync;
import '../../utils/math_utils.dart';
import '../brick/catcher_body.dart';
import 'shark_sprite.dart';


class Shark extends BodyComponent with ContactCallbacks {

  final Vector2 pos;
  final double directionX;
  final List<Vector2> sharkPoints;
  Shark ({required this.pos,required this.sharkPoints, this.directionX = 1});
  late SharkSprite sprite;

  Random _rng = Random();
  Vector2 _velocityDir = Vector2.zero();
  double _speed = 500;
  Vector2 _newPos = Vector2.zero();
  bool _willUpdatePos = false;

  @override
  Future<void> onLoad() async {
    sprite = SharkSprite();
    await add(sprite);

    _velocityDir.x = directionX;
    _flipSpriteByXDirection(_velocityDir.x);
    renderBody = false;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if(_willUpdatePos)
    {
      body.setTransform(_newPos, angle);
      _willUpdatePos = false;
    }

    body.linearVelocity += _velocityDir * _speed * dt;
    body.position.y.clamp(sprite.height, GameWorld.bounds.height - sprite.height);
  }

  void setPosition(Vector2 pos)
  {
     _newPos = Vector2(pos.x + sprite.width * 0.5,pos.y - sprite.height * 0.5);
     _willUpdatePos = true;
  }

  void _flipSpriteByXDirection(double xDir)
  {
    if( xDir < 0 && !sprite.isFlippedHorizontally) {
      sprite.flipHorizontally();
    }
    else if ( xDir > 0 && sprite.isFlippedHorizontally) {
      sprite.flipHorizontally();
    }

  }

  void _updateFaceMovement()
  {
    if(sprite.isFlippedHorizontally)
      _velocityDir.x = -1;
    else
      _velocityDir.x = 1;
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      userData: this,
      position: Vector2(pos.x + sprite.width * 0.5,pos.y - sprite.height * 0.5),
      gravityScale: Vector2.zero(),
      linearDamping: 3,
      fixedRotation: true,
    );

    final fixtureDef = FixtureDef(
      PolygonShape()..setAsBoxXY(sprite.width * 0.35,sprite.height * 0.4),
      isSensor: true,
    );

    final body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);
    return body;
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is CatcherBody) {
      _randomizeSpawn();
    }
    super.beginContact(other, contact);
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