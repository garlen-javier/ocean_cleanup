

import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocean_cleanup/game_manager.dart';
import '../bloc/game/game_barrel.dart';
import '../bloc/game_bloc_parameters.dart';
import '../bloc/game_stats/game_stats_barrel.dart';
import '../constants.dart';
import '../mixins/update_mixin.dart';
import '../worlds/game_world.dart';
import '../worlds/hud_world.dart';

class GameScene extends FlameGame with HasKeyboardHandlerComponents{

  final GameBlocParameters blocParameters;

  GameScene({
    required this.blocParameters,
  });

  late GameManager _gameManager;
  late CameraComponent gameCamera;
  late CameraComponent hudCamera;

  @override
  Color backgroundColor() => Colors.blueAccent;

  @override
  FutureOr<void> onLoad() async{
    await _loadGameManager();
    await _loadGame();
    blocParameters.gameBloc.add(GameStart(_gameManager.loadLevel,3));
    return super.onLoad();
  }

  Future<void> _loadGame() async {
    await _loadResources();
    await _loadCameras();
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
      pathFishNet,
      pathHealth,
      'onscreen_control_knob.png',
      'onscreen_control_base.png',
    ]);
  }

  Future<void> _loadCameras() async {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;

    gameCamera = CameraComponent.withFixedResolution(
      width: GameWorld.worldSize.width,
      height: GameWorld.worldSize.height,
    );

    gameCamera.viewfinder
      ..zoom = 0.5
      ..position = Vector2(GameWorld.worldSize.width, GameWorld.worldSize.height);
    // ..anchor = Anchor.topLeft;

    hudCamera = CameraComponent.withFixedResolution(
      width: view.physicalSize.width / view.devicePixelRatio,
      height: view.physicalSize.height / view.devicePixelRatio,
    );

    await addAll([gameCamera, hudCamera]);
  }

  Future<void> _loadGameManager() async {
    _gameManager = GameManager(gameScene:this,blocParameters:blocParameters);
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<GameBloc, GameState>.value(
            value: blocParameters.gameBloc,
          ),
          FlameBlocProvider<GameStatsBloc, GameStatsState>.value(
            value: blocParameters.gameStatsBloc,
          ),
        ],
        children: [
          _gameManager,
        ],
      ),
    );
  }

  @override
  void update(double dt) {
    if(hasChildren) {
      children.forEach((child) {
        if(child is HasUpdateMixin){
          if(_gameManager.gamePhase == GamePhase.playing)
            (child as dynamic)?.runUpdate(dt);
        }
      });
    }
    super.update(dt);
  }

  @override
  void onDispose() {
     blocParameters.gameBloc.close();
     blocParameters.gameStatsBloc.close();
     blocParameters.joystickMovementBloc.close();
    // removeAll(children);
    // Flame.images.clearCache();
    // Flame.assets.clearCache();
    //TiledAtlas.clearCache();
    super.onDispose();
  }

  ///TODO: to remove
  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {

    if (event.logicalKey == LogicalKeyboardKey.keyP) {
      debugPrint("pressed P: testing");
      blocParameters.gameBloc.add(const GamePause());
      //blocParameters.gameBloc.add(GameWin(_gameManager.currentLevelIndex));
    }
    else if(event.logicalKey == LogicalKeyboardKey.keyO){
      debugPrint("pressed O: testing");
      blocParameters.gameBloc.add(const GameResume());
    }
    return super.onKeyEvent(event, keysPressed);
  }

}
