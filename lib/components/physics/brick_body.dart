import 'package:flame_forge2d/flame_forge2d.dart';

class BrickBody extends BodyComponent {
  final Vector2 pos;
  final double width;
  final double height;

  BrickBody ({required this.pos,required this.width,required this.height});

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