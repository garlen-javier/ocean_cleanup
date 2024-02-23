

import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocean_cleanup/game_manager.dart';
import '../bloc/game_bloc_parameters.dart';
import '../constants.dart';
import '../worlds/game_world.dart';
import '../worlds/hud_world.dart';

class GameScene extends FlameGame with HasKeyboardHandlerComponents{

  final GameBlocParameters blocParameters;

  GameScene({
    required this.blocParameters,
  });

  late GameManager _gameManager;
  late CameraComponent gameCamera;
  late HudWorld hudWorld;

  @override
  Color backgroundColor() => Colors.blueAccent;

  @override
  FutureOr<void> onLoad() async{
    await _loadResources();
    await _loadWorlds();
    await _loadGameManager();
    return super.onLoad();
  }

  Future<void> _loadResources() async {
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

  Future<void> _loadWorlds() async {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;

    gameCamera = CameraComponent.withFixedResolution(
         width: GameWorld.worldSize.width,
         height: GameWorld.worldSize.height,
       );

    gameCamera.viewfinder
      ..zoom = 0.5
      ..position = Vector2(GameWorld.worldSize.width, GameWorld.worldSize.height);
     // ..anchor = Anchor.topLeft;

    hudWorld = HudWorld(blocParameters: blocParameters);
    final hudCamera = CameraComponent.withFixedResolution(
      width: view.physicalSize.width / view.devicePixelRatio,
      height: view.physicalSize.height / view.devicePixelRatio,
      world: hudWorld,
    );

     await addAll([gameCamera, hudWorld ,hudCamera]);
  }

  Future<void> _loadGameManager() async {
    _gameManager = GameManager(gameScene: this,blocParameters:blocParameters);
    await add(_gameManager);
    await _gameManager.loadLevel(0);
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
      _gameManager.loadLevel(1);
    }
    return super.onKeyEvent(event, keysPressed);
  }

}
