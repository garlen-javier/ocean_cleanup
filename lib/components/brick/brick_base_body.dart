import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

abstract class BrickBaseBody extends PositionComponent {
  final Vector2 pos;
  final double width;
  final double height;

  BrickBaseBody ({required this.pos,required this.width,required this.height});

  @override
  Future<void> onLoad() async {
    position = pos;
    add(RectangleHitbox(size:Vector2(width,height),isSolid: true,collisionType: CollisionType.passive));
    return super.onLoad();
  }

 }