import 'package:flame_forge2d/flame_forge2d.dart';

abstract class BrickBaseBody extends BodyComponent {
  final Vector2 pos;
  final double width;
  final double height;

  BrickBaseBody ({required this.pos,required this.width,required this.height});

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      type: BodyType.static,
      userData: this,
      position: pos,
    );

    final shape = PolygonShape()..setAsBoxXY(width, height);
    final body = world.createBody(bodyDef)
      ..userData = this;
    body.createFixtureFromShape(shape);
    //renderBody = false;
    return body;
  }
}