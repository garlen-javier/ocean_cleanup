import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:ocean_cleanup/components/brick/catcher_body.dart';
import 'package:ocean_cleanup/worlds/game_world.dart';
import 'dart:async' as dartAsync;
import 'trash_sprite.dart';


class TrashBody extends BodyComponent with ContactCallbacks{
  final Vector2 pos;
  final int directionX;

  TrashBody ({required this.pos,this.directionX = 1});
  late TrashSprite sprite;

  final double _amplitude = 20.0; // Adjust the amplitude of the wiggle
  final double _frequency = 2.0; // Adjust the frequency of the wiggle
  double _speed = 4;
  double _velocity = 0.0;

  @override
  Future<void> onLoad() async {
    sprite = TrashSprite();
    await add(sprite);

    renderBody = false;
    return super.onLoad();
  }

  void removeWithParent()
  {
    parent?.removeFromParent();
    parent = null;
  }

  @override
  void update(double dt) {
    super.update(dt);
    double x = _velocity * directionX;
    double y = _amplitude * sin(_velocity * _frequency);

    body.linearVelocity+= Vector2(x,y);
     _velocity += _speed * dt;
     body.position.y.clamp(sprite.height, GameWorld.bounds.height - sprite.height);
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      userData: this,
      position: Vector2(pos.x + sprite.width * 0.5,pos.y - sprite.height * 0.5),
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

  @override
  void beginContact(Object other, Contact contact) {
    if (other is CatcherBody) {
      removeWithParent();
    }
    super.beginContact(other, contact);
  }


}