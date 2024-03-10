

import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:ocean_cleanup/bloc/game_stats/game_stats_barrel.dart';
import 'package:ocean_cleanup/components/lightning.dart';
import 'package:ocean_cleanup/components/octopus/octopus.dart';
import 'package:ocean_cleanup/components/player/player_controller.dart';
import 'package:ocean_cleanup/components/shark/shark.dart';
import 'package:ocean_cleanup/constants.dart';
import 'package:ocean_cleanup/framework/object_pool.dart';
import 'package:ocean_cleanup/levels/level_parameters.dart';
import '../bloc/game_bloc_parameters.dart';
import '../components/brick/catcher_body.dart';
import '../components/bubble_particle.dart';
import '../components/player/player.dart';
import 'package:flame/src/camera/world.dart' as camWorld;
import '../components/trash/trash.dart';
import '../core/audio_manager.dart';
import '../core/game_manager.dart';
import '../mixins/update_mixin.dart';
import '../scenes/game_scene.dart';


class GameWorld extends World with HasCollisionDetection,HasUpdateMixin,HasGameRef<GameScene>
{
  static const Size worldSize = Size(16 * 25,16 * 15);
  static final Rectangle bounds = Rectangle.fromLTRB(0, 0 , worldSize.width * 2, worldSize.height * 2);

  final GameManager gameManager;
  final GameBlocParameters blocParameters;

  GameWorld({required this.gameManager,required this.blocParameters}):super();

  late TiledComponent<FlameGame<camWorld.World>> map;
  final ObjectPool<Trash> _trashPool = ObjectPool<Trash>(18, () => Trash(),);
  final List<double> _bubbleSizes = [12.0, 8.0, 6.0];
  final _random = Random();

  PlayerController? playerController;
  Octopus? octopus;
  Timer? _bubbleSpawner;

  List<Vector2> _sharkPoints = [];
  List<Vector2> _bubblePoints = [];
  List<SpawnComponent> _trashSpawners = [];

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
    await _loadOctopus();
    await _loadBubbles();
  }

  Future<void> _initPlayer() async {
    LevelParameters params = gameManager.currentLevelParams;
    Player player = Player(
        position:Vector2(worldSize.width ,worldSize.height),
        statsBloc: blocParameters.gameStatsBloc,
        speed: params.playerSpeed,
    );
    await add(player);
    await _addPlayerController(player);
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

  //#region Trash
  Future<void> _loadTrashPoints() async {

    LevelParameters levelParams = gameManager.currentLevelParams;
    loadSpawner(String layerName,int direction) async {
      ObjectGroup? objGroup = map.tileMap.getLayer<ObjectGroup>(layerName);
      if(objGroup != null)
      {
        objGroup.objects.shuffle();
        _trashSpawners.clear();

        int i = 0;
        int firstSpawn = _random.nextInt(objGroup.objects.length-1);
        for(var col in objGroup.objects)
        {
          //Spawn first set of trashes first
          if(i < firstSpawn) {
            i++;
            Trash firstTrash = _randomTrash(pos: Vector2(col.x, col.y),
                speed: levelParams.trashSpeed,
                directionX: direction);
            await add(
                TimerComponent(
                  period: _random.nextDouble() * 2.5,
                  repeat: false,
                  removeOnFinish: true,
                  onTick: () => add(firstTrash),
                )
            );
          }

          SpawnComponent spawner = SpawnComponent.periodRange(
            factory: (i)  {
              Trash trash = _randomTrash(pos: Vector2(col.x ,col.y), speed: levelParams.trashSpeed, directionX: direction);
              return trash;
            },
            minPeriod: levelParams.trashSpawnMin,
            maxPeriod: levelParams.trashSpawnMax,
            selfPositioning: true,
          );
          await add(spawner);
          _trashSpawners.add(spawner);
        }
      }
    }

    loadSpawner("trash_points_left",1);
    loadSpawner("trash_points_right",-1);
  }

  Trash _randomTrash({required Vector2 pos,required double speed,required directionX})
  {
    TrashType type = gameManager.randomizeTrashType();
    Trash trash = _trashPool.getObjectFromPool();
    trash.setup(
        pos: pos,
        trashType: type,
        speed: speed,
        directionX: directionX,
        trashPool: _trashPool);
    return trash;
  }

  void pauseTrashSpawn()
  {
    for(int i = 0; i < _trashSpawners.length; ++i)
    {
      if(_trashSpawners[i].timer.isRunning())
        _trashSpawners[i].timer.pause();
      else
        _trashSpawners[i].timer.resume();
    }
  }

  void stopTrashSpawn()
  {
    for(int i = 0; i < _trashSpawners.length; ++i)
    {
      _trashSpawners[i].timer.stop();
    }
  }

  void startTrashSpawn()
  {
    for(int i = 0; i < _trashSpawners.length; ++i)
    {
      _trashSpawners[i].timer.start();
    }
  }

  void resumeTrashSpawn()
  {
    for(int i = 0; i < _trashSpawners.length; ++i)
    {
        _trashSpawners[i].timer.resume();
    }
  }

  //#endregion

  Future<void> _loadSharkPoints() async {
    ObjectGroup? objGroup = map.tileMap.getLayer<ObjectGroup>("shark_points");
    if(objGroup != null)
    {
      _sharkPoints.clear();
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

  Future<void> _spawnLightning() async {

    List<Vector2> leftPos = [];
    List<Vector2> rightPos = [];
    List<Vector2> upPos = [];
    List<Vector2> downPos = [];

    loadPoints(String layerName,List<Vector2> vecList) {
      ObjectGroup? objGroup = map.tileMap.getLayer<ObjectGroup>(layerName);
      if (objGroup != null) {
        for (var col in objGroup.objects) {
          vecList.add(Vector2(col.x, col.y));
        }
      }
    }

    spawnHorizontal(List<Vector2> fromList,List<Vector2> toList) async{
      toList.shuffle();
      for(int i = 0; i < fromList.length; ++i)
      {
        Vector2 from = fromList[i];
        Vector2 to = toList[i]; //toList must  have same length with fromList
        Lightning lightning = Lightning(from: from, to: to,upperDir:rightPos,lowerDir: leftPos, direction: LightningDirection.horizontal);
        await add(lightning);
      }
    }

    spawnVertical(List<Vector2> fromList,List<Vector2> toList) async{
      toList.shuffle();
      for(int i = 0; i < fromList.length; ++i)
      {
        Vector2 from = fromList[i];
        Vector2 to = toList[i]; //toList must have same length with fromList
        Lightning lightning = Lightning(from: from, to: to,upperDir:upPos,lowerDir:downPos,direction: LightningDirection.vertical);
        await add(lightning);
      }
    }

    loadPoints("lightning_points_left",leftPos);
    loadPoints("lightning_points_right",rightPos);
    loadPoints("lightning_points_up",upPos);
    loadPoints("lightning_points_down",downPos);

    await spawnHorizontal(leftPos, rightPos);
    await spawnHorizontal(rightPos, leftPos);
    await spawnVertical(upPos, downPos);
    await spawnVertical(downPos, upPos);
  }

  Future<void> _loadOctopus() async {
    if(gameManager.currentLevelParams.levelType == LevelType.boss) {
      octopus = Octopus(
        onAngry: () async {
          stopTrashSpawn();
          await _spawnLightning();
          await AudioManager.instance.playSfx(pathSfxLightning);
        }, onStopAttack: () {
        //Reset stage
         octopus!.notifyListeners();
         gameManager.resetStage();
         startTrashSpawn();
      },);

      await add(
        FlameMultiBlocProvider(
          providers: [
            FlameBlocProvider<GameStatsBloc, GameStatsState>.value(
              value: blocParameters.gameStatsBloc,
            ),
          ],
          children: [
            octopus!,
          ],
        ),
      );

    }
  }
  //#region Bubbles
  Future<void> _loadBubbles() async {
    ObjectGroup? objGroup = map.tileMap.getLayer<ObjectGroup>("bubble_points");
    if(objGroup != null)
    {
      _bubblePoints.clear();
      for(var col in objGroup.objects)
         _bubblePoints.add(Vector2(col.x, col.y));
    }

    _bubbleSpawner = Timer(
      0.5,
      onTick: () => _spawnBubbles(),
      repeat: true,
    );
  }

  void _spawnBubbles()
  {
    for(Vector2 pos in _bubblePoints)
    {
      Vector2 newPos = Vector2(pos.x + 37 * 0.5,pos.y - 37 * 0.5);
      _spawnBubble(newPos);
    }
  }

  void _spawnBubble(Vector2 pos)   {
    var from = Vector2(pos.x, pos.y);
    var to =  Vector2(pos.x, -GameWorld.bounds.height);
    from.x+=_random.nextDouble() * 20 - 10;
    to.x+=_random.nextDouble() * 20 - 10;

    const double min = 10.0;
    const double max = 12.0;
    double lifeSpan = min + _random.nextDouble() * (max - min);

    _bubbleSizes.shuffle();
    var sprite =  Sprite(gameRef.images.fromCache(pathBubble));
    add(BubbleParticle(
      from: from,
      to: to,
      sprite: sprite,
      lifeSpan: lifeSpan,
      randomSizes: _bubbleSizes,
    ));
  }
  //#endregion

  Future<void> _addPlayerController(Player player) async {
    playerController = PlayerController(player: player);
    await add(playerController!);
  }

  @override
  void update(double dt) {
    _bubbleSpawner?.update(dt);
    super.update(dt);
  }

  @override
  void runUpdate(double dt) {
    if(hasChildren) {
      for (var child in children) {
        if(child is UpdateMixin){
          (child as dynamic)?.runUpdate(dt);
        }
      }
      octopus?.runUpdate(dt);
    }
  }

  @override
  void onRemove() {
    playerController = null;
    octopus = null;
    _bubbleSpawner = null;
    _trashPool.clearPool();
    super.onRemove();
  }

}