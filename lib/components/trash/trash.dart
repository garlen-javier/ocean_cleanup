import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:ocean_cleanup/components/trash/trash_sprite.dart';

class Trash extends BodyComponent {
  final Vector2 pos;

  Trash ({required this.pos});
  late TrashSprite sprite;

  @override
  Future<void> onLoad() async {
    sprite = TrashSprite();
    await add(sprite);
    return super.onLoad();
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      type: BodyType.static,
      userData: this,
      position: pos,
    );

    final fixtureDef = FixtureDef(
      PolygonShape()..setAsBoxXY(sprite.width * 0.5,sprite.height * 0.5),
      isSensor: true,
    );

    final body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);

    //renderBody = false;
    return body;
  }
}