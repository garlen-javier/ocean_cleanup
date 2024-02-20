

import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:ocean_cleanup/components/player/player_controller.dart';
import '../bloc/bloc_parameters.dart';
import '../bloc/joystick_movement/joystick_movement_barrel.dart';
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

  final BlocParameters blocParameters;

  GameWorld({required this.blocParameters}):super();

  late Player player;
  late TiledComponent<FlameGame<camWorld.World>> map;

  @override
  FutureOr<void> onLoad() async {

    await _initLevel();
    await _initPlayer();

    // var sp = await Sprite.load("background.png");
    // SpriteComponent bg = SpriteComponent(sprite: sp);
    // await add(bg);
    return super.onLoad();
  }

  Future<void> _initLevel() async {
    map = await TiledComponent.load('stage1.tmx', Vector2.all(32));
    await add(map);

    await _loadCollisions();
    await _loadTrash();
  }

  Future<void> _initPlayer() async {
    player = Player(Vector2(worldSize.width ,worldSize.height),
        scale: Vector2.all(0.5),
        statsBloc: blocParameters.playerStatsBloc);
    await add(player);
    await _addPlayerController(player);
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
      }
    }
  }

  Future<void> _addPlayerController(Player player) async {
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<JoystickMovementBloc, JoystickMovementState>.value(
            value: blocParameters.joystickMovementBloc,
          ),
        ],
        children: [
          PlayerController(player: player),
        ],
      ),
    );
  }



}