

import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:ocean_cleanup/components/player/player_controller.dart';
import 'package:ocean_cleanup/components/shark/shark.dart';
import '../bloc/game_bloc_parameters.dart';
import '../bloc/joystick_movement/joystick_movement_barrel.dart';
import '../components/brick/catcher_body.dart';
import '../components/player/player.dart';
import 'package:flame/src/camera/world.dart' as camWorld;
import '../components/trash/trash.dart';


class GameWorld extends World with HasCollisionDetection
{
  static const Size worldSize = Size(16 * 25,16 * 15);
  static final Rectangle bounds = Rectangle.fromLTRB(0, 0 , worldSize.width * 2, worldSize.height * 2);

  final GameBlocParameters blocParameters;

  GameWorld({required this.blocParameters}):super();

  late Player player;
  late TiledComponent<FlameGame<camWorld.World>> map;
  List<Vector2> _sharkPoints = [];
  int sharkCount = 2;

  @override
  FutureOr<void> onLoad() async {

    await _initLevel();
    await _initPlayer();
    return super.onLoad();
  }

  Future<void> _initLevel() async {
    map = await TiledComponent.load('stage1.tmx', Vector2.all(32));
    await add(map);

    await _loadCatchers();
    await _loadTrashPoints();
    await _loadSharkPoints();
  }

  Future<void> _initPlayer() async {
    player = Player(Vector2(worldSize.width ,worldSize.height),
        statsBloc: blocParameters.playerStatsBloc);
    await add(player);
    await _addPlayerController(player);
  }


  Future<void> _loadCatchers() async {
    ObjectGroup? objGroup = map.tileMap.getLayer<ObjectGroup>("catcher");
    if(objGroup != null)
    {
      for(var col in objGroup.objects)
      {
        CatcherBody brick = CatcherBody(pos:Vector2(col.x + 16,col.y + 16), width:col.width - 16,height: col.height - 16);
        add(brick);
      }
    }
  }

  Future<void> _loadTrashPoints() async {
    loadSpawner(String layerName,int direction)
    async {
      ObjectGroup? objGroup = map.tileMap.getLayer<ObjectGroup>(layerName);
      if(objGroup != null)
      {
        for(var col in objGroup.objects)
        {
          SpawnComponent spawner = SpawnComponent.periodRange(
            factory: (i)  {
              return Trash(pos:Vector2(col.x ,col.y),directionX: direction);
            },
            minPeriod: 1,
            maxPeriod: 15,
            selfPositioning: true,
          );
          await add(spawner);
        }
      }
    }

    loadSpawner("trash_points_left",1);
    loadSpawner("trash_points_right",-1);
  }

  Future<void> _loadSharkPoints() async {
    ObjectGroup? objGroup = map.tileMap.getLayer<ObjectGroup>("shark_points");
    if(objGroup != null)
    {
      for(var col in objGroup.objects)
      {
        _sharkPoints.add(Vector2(col.x, col.y));
      }
    }

    _sharkPoints.shuffle();
    for(int i = 0; i < 3; ++i){
      Vector2 pos = _sharkPoints[i];
      Shark shark = Shark(pos: pos,sharkPoints: _sharkPoints, directionX: -pos.x.sign);
      await add(shark);
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