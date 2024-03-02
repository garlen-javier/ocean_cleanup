

import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:ocean_cleanup/components/player/player_controller.dart';
import 'package:ocean_cleanup/components/shark/shark.dart';
import 'package:ocean_cleanup/constants.dart';
import 'package:ocean_cleanup/framework/object_pool.dart';
import 'package:ocean_cleanup/levels/level_parameters.dart';
import '../bloc/game_bloc_parameters.dart';
import '../components/brick/catcher_body.dart';
import '../components/player/player.dart';
import 'package:flame/src/camera/world.dart' as camWorld;
import '../components/trash/trash.dart';
import '../core/game_manager.dart';
import '../mixins/update_mixin.dart';


class GameWorld extends World with HasCollisionDetection,HasUpdateMixin
{
  static const Size worldSize = Size(16 * 25,16 * 15);
  static final Rectangle bounds = Rectangle.fromLTRB(0, 0 , worldSize.width * 2, worldSize.height * 2);

  final GameManager gameManager;
  final GameBlocParameters blocParameters;

  GameWorld({required this.gameManager,required this.blocParameters}):super();

  late PlayerController playerController;
  late TiledComponent<FlameGame<camWorld.World>> map;
  final ObjectPool<Trash> _trashPool = ObjectPool<Trash>(18, () => Trash(),);
  List<Vector2> _sharkPoints = [];
  List<SpawnComponent> _spawners = [];

  @override
  FutureOr<void> onLoad() async {
    await _initLevel();
    await _initPlayer();
    return super.onLoad();
  }

  Future<void> _initLevel() async {
    map = await TiledComponent.load('stage1.tmx', Vector2.all(32));
    await add(map);

    _displayCorals();
    await _loadCatchers();
    await _loadTrashPoints();
    await _loadSharkPoints();
  }

  Future<void> _initPlayer() async {
    LevelParameters params = gameManager.currentLevelParams;
    Player player = Player(
        position:Vector2(worldSize.width ,worldSize.height),
        statsBloc: blocParameters.gameStatsBloc,
        speed: params.playerSpeed,
    );
    await add(player!);
    await _addPlayerController(player!);
  }

  void _displayCorals()
  {
    for (var entry in coralsPathMap.entries) {
      var key = entry.key;
      var value = entry.value;

      String groupName = value;
      Group? coralGroup = map.tileMap.getLayer<Group>(groupName);
      coralGroup?.visible = false;
      if(key == gameManager.currentLevelIndex) {
        coralGroup?.visible = true;
        break;
      }
    }
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

    LevelParameters levelParams = gameManager.currentLevelParams;
    loadSpawner(String layerName,int direction) async {
      ObjectGroup? objGroup = map.tileMap.getLayer<ObjectGroup>(layerName);
      if(objGroup != null)
      {
        _spawners.clear();
        for(var col in objGroup.objects)
        {
          SpawnComponent spawner = SpawnComponent.periodRange(
            factory: (i)  {
              TrashType type = gameManager.randomizeTrashType();
              Trash trash = _trashPool.getObjectFromPool();
              trash.setup(
                  pos: Vector2(col.x ,col.y),
                  trashType: type,
                  speed: levelParams.trashSpeed,
                  directionX: direction,
                  trashPool: _trashPool);
              return trash;
            },
            minPeriod: levelParams.trashSpawnMin,
            maxPeriod: levelParams.trashSpawnMax,
            selfPositioning: true,
          );
          await add(spawner);
          _spawners.add(spawner);
        }
      }
    }

    loadSpawner("trash_points_left",1);
    loadSpawner("trash_points_right",-1);
  }

  void pauseTrashSpawn()
  {
    for(int i = 0; i < _spawners.length; ++i)
    {
      if(_spawners[i].timer.isRunning())
        _spawners[i].timer.pause();
      else
        _spawners[i].timer.resume();
    }
  }

  void resumeTrashSpawn()
  {
    for(int i = 0; i < _spawners.length; ++i)
    {
        _spawners[i].timer.resume();
    }
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

    LevelParameters params = gameManager.currentLevelParams;
    SharkConfig sharkConfig = params.sharkConfig;
    int sharkCount = sharkConfig.count;
    double sharkSpeed = sharkConfig.speed;

    _sharkPoints.shuffle();
    for(int i = 0; i < sharkCount; ++i){
      Vector2 pos = _sharkPoints[i];
      Shark shark = Shark(
          pos: pos,
          speed: sharkSpeed,
          sharkPoints: _sharkPoints,
          directionX: -pos.x.sign);
      await add(shark);

    }
  }

  Future<void> _addPlayerController(Player player) async {
    playerController = PlayerController(player: player);
    await add(playerController);
  }

  @override
  void runUpdate(double dt) {
    if(hasChildren) {
      children.forEach((child) {
        if(child is UpdateMixin){
          (child as dynamic)?.runUpdate(dt);
        }
      });
    }
  }

  @override
  void onRemove() {
    _trashPool.clearPool();
    super.onRemove();
  }

}