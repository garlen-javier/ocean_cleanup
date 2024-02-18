

import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import '../bloc/player_movement/player_movement_bloc.dart';
import '../bloc/player_movement/player_movement_state.dart';
import '../components/brick/brick_body.dart';
import '../components/player/player.dart';
import 'package:flame/src/camera/world.dart' as camWorld;
import '../components/trash/trash.dart';
import '../components/trash/trash_sprite.dart';


///Used Forge2DWorld incase we need to add levels with collision
class GameWorld extends Forge2DWorld
{
  static const Size worldSize = Size(16 * 25,16 * 15);
  static final Rectangle bounds = Rectangle.fromLTRB(0, 0 , worldSize.width * 2, worldSize.height * 2);

  final PlayerMovementBloc playerMovementBloc;
  GameWorld({required this.playerMovementBloc}):super();

  late Player player;
  late TiledComponent<FlameGame<camWorld.World>> map;

  var trashes = <TrashSprite>{};

  @override
  FutureOr<void> onLoad() async {

    await _initLevel();

    player = Player(Vector2(worldSize.width ,worldSize.height),scale: Vector2.all(0.5));
    await _addPlayerBloc(player);
    await add(player);

    return super.onLoad();
  }

  Future<void> _initLevel() async {
    map = await TiledComponent.load('stage1.tmx', Vector2.all(32));
    await add(map);

    await _loadCollisions();
    await _loadTrash();
  }

  Future<void> _loadCollisions() async {
    ObjectGroup? objGroup = map.tileMap.getLayer<ObjectGroup>("collisions");
    if(objGroup != null)
    {
      for(var col in objGroup.objects)
      {
        BrickBody brick = BrickBody(pos:Vector2(col.x + 16,col.y + 16), width:col.width - 16,height: col.height - 16);
        add(brick);
      }
    }
  }

  Future<void> _loadTrash() async {
    ObjectGroup? objGroup = map.tileMap.getLayer<ObjectGroup>("trash");
    if(objGroup != null)
    {
      for(var col in objGroup.objects)
      {
        Trash trash = Trash(pos:Vector2(col.x + 16,col.y + 16));
        add(trash);
        //trashes.add(trash);
      }
    }
  }

  ///Should be called first before adding the player to the world.
  Future<void> _addPlayerBloc(Player player) async {
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<PlayerMovementBloc, PlayerMovementState>.value(
            value: playerMovementBloc,
          ),
        ],
        children: [
          player,
        ],
      ),
    );
  }

  @override
  void update(double dt) {
    if(player != null)
    {
     // print("player pos " + player.position.toString());
     // print("player widht " + player.height.toString());
     //  for(var trash in trashes)
     //  {
     //    //print("trash " + trash.width.toString());
     //      if(isCollide(trash))
     //        {
     //          print("Collide");
     //          trash.removeFromParent();
     //        }
     //
     //    // if(player.containsLocalPoint(trash.position))
     //    // {
     //    //   print("Collide");
     //    // }
     //  }
    }
    super.update(dt);
  }





}