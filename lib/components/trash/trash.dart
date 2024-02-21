

import 'dart:async';

import 'package:flame/components.dart';
import 'package:ocean_cleanup/components/trash/trash_body.dart';
import 'package:ocean_cleanup/components/trash/trash_sprite.dart';

class Trash extends PositionComponent
{
  final Vector2 pos;
  final int directionX;
  Trash ({required this.pos,this.directionX = 1});
  late TrashBody body;

  @override
  FutureOr<void> onLoad() async{
    body = TrashBody(pos: pos,directionX: directionX);
    await add(body);
    return super.onLoad();
  }

}