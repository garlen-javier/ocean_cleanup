import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:ocean_cleanup/components/trash/trash.dart';
import 'package:ocean_cleanup/utils/utils.dart';
import 'player_sprite.dart';

class Player extends BodyComponent with ContactCallbacks{

  Vector2 pos;
  Vector2? scale;

  Player(this.pos,{this.scale}):super(){
    scale = scale ?? Vector2.all(1);
  }

  Vector2 _velocity = Vector2.zero();
  double _speed = 300;
  late PlayerSprite sprite;

  @override
  Future<void> onLoad() async {
    sprite = PlayerSprite();
    sprite.scale = scale!;
    await add(sprite);
    //renderBody = false;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    body.linearVelocity+= _velocity * _speed * dt;
  }

  void updateDirection(Vector2 pVelocity,double pAngle) {
    _velocity = pVelocity;
    if(pVelocity != Vector2.zero())
      angle = pAngle;
  }

  @override
  double angle = 0;

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
      PolygonShape()..setAsBoxXY((sprite.width * 0.5) * scale!.x,(sprite.height * 0.5) * scale!.y),
      isSensor: false,
    );

    final body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);
    return body;
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Trash) {
      Trash trash = other;
      trash.removeFromParent();
    }
    super.beginContact(other, contact);
  }



}