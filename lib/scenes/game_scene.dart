

import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocean_cleanup/levels/levels.dart';
import 'package:ocean_cleanup/worlds/level_factory.dart';
import '../bloc/game_bloc_parameters.dart';
import '../components/player/player.dart';
import '../constants.dart';
import '../worlds/game_world.dart';
import '../worlds/hud_world.dart';

class GameScene extends FlameGame with HasKeyboardHandlerComponents{

  final GameBlocParameters blocParameters;

  GameScene({
    required this.blocParameters,
  });

  late CameraComponent _gameCamera;
  late final LevelFactory _levelFactory = LevelFactory();
  late final Levels _levels = Levels();
  World? currentLevel;

  @override
  Color backgroundColor() => Colors.blueAccent;

  @override
  FutureOr<void> onLoad() async{
    await loadResources();
    await loadWorlds();
    return super.onLoad();
  }

  Future<void> loadResources() async {
    await images.loadAll([
      pathPlayer,
      pathShark,
      pathBagTrash,
      pathCutleries,
      pathPlasticCup,
      pathStraw,
      pathStyrofoam,
      pathWaterBottle,
      pathWaterGallon,
      pathDolphin,
      'onscreen_control_knob.png',
      'onscreen_control_base.png',
    ]);
  }

  Future<void> loadWorlds() async {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;

    _gameCamera = CameraComponent.withFixedResolution(
         width: GameWorld.worldSize.width,
         height: GameWorld.worldSize.height,
       );

    _gameCamera.viewfinder
      ..zoom = 0.5
      ..position = Vector2(GameWorld.worldSize.width, GameWorld.worldSize.height);
     // ..anchor = Anchor.topLeft;

    final hudWorld = HudWorld(blocParameters: blocParameters);
    final hudCamera = CameraComponent.withFixedResolution(
      width: view.physicalSize.width / view.devicePixelRatio,
      height: view.physicalSize.height / view.devicePixelRatio,
      world: hudWorld,
    );

     await addAll([_gameCamera, hudWorld ,hudCamera]);
     await loadLevel(0);
    //_zoomFollowPlayer(gameCamera, gameWorld.player);
  }

  Future<void> loadLevel(int levelIndex) async
  {
    if(currentLevel != null)
      remove(currentLevel!);

    World level = _levelFactory.createLevel(blocParameters,_levels.params[levelIndex]);
    currentLevel = level;
    _gameCamera.world = currentLevel;
    add(currentLevel!);
  }

  void _zoomFollowPlayer(CameraComponent cam,Player player)
  {
    cam.viewfinder.zoom = 1;
    cam.setBounds(GameWorld.bounds);
    cam.follow(player, maxSpeed: 450);
  }

  @override
  void onRemove() {
    super.onRemove();
    //removeAll(children);
    //Flame.images.clearCache();
    //Flame.assets.clearCache();
    //TiledAtlas.clearCache();
  }

  ///TODO: to remove
  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {

    if (event.logicalKey == LogicalKeyboardKey.keyP) {
      debugPrint("pressed p: testing");
      loadLevel(1);
    }
    return super.onKeyEvent(event, keysPressed);
  }

}
