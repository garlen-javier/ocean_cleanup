import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:ocean_cleanup/bloc/player_stats/player_stats_barrel.dart';
import 'package:ocean_cleanup/components/trash/trash.dart';
import 'package:ocean_cleanup/constants.dart';
import 'package:ocean_cleanup/utils/math_utils.dart';
import '../../worlds/game_world.dart';
import '../trash/trash_body.dart';
import 'player_sprite.dart';

class Player extends BodyComponent with ContactCallbacks{

  Vector2 pos;
  Vector2? scale;
  PlayerStatsBloc statsBloc;

  Player(this.pos,{this.scale,required this.statsBloc}):super(){
    scale = scale ?? Vector2.all(1);
  }

  late PlayerSprite sprite;
  Vector2 _velocity = Vector2.zero();
  double _speed = 300;
  List<TrashBody> trashes = [];

  @override
  Future<void> onLoad() async {
    sprite = PlayerSprite();
    sprite.scale = scale!;
    await add(sprite);

    priority = playerPriority;
    renderBody = false;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    body.linearVelocity+= _velocity * _speed * dt;
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
    sprite.current = PlayerAnimationState.catching;
  }

  void _updateAnimationByDirection(Vector2 dir)
  {
    if(dir == Vector2.zero()) {
      sprite.current = PlayerAnimationState.idle;
    }
    else{
      if(sprite.current != PlayerAnimationState.running)
        sprite.current = PlayerAnimationState.running;
    }
  }

  void _flipSpriteByDirection(Vector2 dir)
  {
    if(dir.x < 0 && !sprite.isFlippedVertically) {
      sprite.flipVertically();
    }
    else if (dir.x > 0 && sprite.isFlippedVertically) {
      sprite.flipVertically();
    }
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
    if (other is TrashBody) {
      TrashBody trash = other;
      trashes.add(trash);
    }
    super.beginContact(other, contact);
  }

  @override
  void endContact(Object other, Contact contact) {
    if (other is TrashBody) {
      TrashBody trash = other;
      if(trashes.contains(trash))
        trashes.remove(trash);
    }
    super.endContact(other, contact);
  }

  void tryRemoveTrash()
  {
    if(trashes.isNotEmpty)
    {
      TrashBody trash = trashes.last;
      //trash.removeFromParent();
      trash.removeWithParent();
      trashes.removeLast();
      statsBloc.addScore(1);
    }
  }




}