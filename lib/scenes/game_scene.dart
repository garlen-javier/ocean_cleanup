

import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocean_cleanup/core/game_manager.dart';
import 'package:ocean_cleanup/levels/level_parameters.dart';
import 'package:ocean_cleanup/utils/save_utils.dart';
import '../bloc/game/game_barrel.dart';
import '../bloc/game_bloc_parameters.dart';
import '../bloc/game_stats/game_stats_barrel.dart';
import '../constants.dart';
import '../mixins/update_mixin.dart';
import '../worlds/game_world.dart';

class GameScene extends FlameGame with HasKeyboardHandlerComponents{

  final GameBlocParameters blocParameters;

  GameScene({
    required this.blocParameters,
  });

  late GameManager _gameManager;
  late CameraComponent gameCamera;
  late CameraComponent hudCamera;

  @override
  Color backgroundColor() => const Color(0xFFf1feff);

  @override
  FutureOr<void> onLoad() async{
    debugPrint("FlameGame: onLoad");
    await SaveUtils.instance.loadData();
    await _loadGameManager();
    await _loadGame();
    FlameAudio.bgm.initialize();
    //TODO: testing
    if(!isTesterMode)
      await _gameManager.loadLevel(1);
    else
      await _gameManager.loadLevel(0);
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
      pathRescueComplete,
      pathRescueFailed,
      pathAnimalFrame,
      'onscreen_control_knob.png',
      'onscreen_control_base.png',
    ]);

    await FlameAudio.audioCache.loadAll([
      pathBgmGame,
      pathSfxCatchTrash,
      pathSfxSwingNet,
      pathSfxReduceHealth,
      pathSfxGameOver,
      pathSfxLevelWin,
      pathSfxAnimalRescued,
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
        )
    );
  }

  @override
  void update(double dt) {
    if(hasChildren) {
      children.forEach((child) {
        if(child is HasUpdateMixin){
          if(_gameManager.gamePhase == GamePhase.playing) {
            (child as dynamic)?.runUpdate(dt);
          }
        }
      });
    }
    super.update(dt);
  }

  @override
  void onRemove() {
    debugPrint("FlameGame: onRemove");
    FlameAudio.bgm.stop();
    blocParameters.gameBloc.add(const Default());
    blocParameters.gameStatsBloc.defaultState();
    super.onRemove();
  }

  @override
  void onDispose() async {
     blocParameters.gameBloc.close();
     blocParameters.gameStatsBloc.close();
     blocParameters.joystickMovementBloc.close();
     FlameAudio.bgm.dispose();
     //Flame.images.clearCache();
    // Flame.assets.clearCache();
   //  await FlameAudio.audioCache.clearAll();
    //TiledAtlas.clearCache();
    super.onDispose();
  }

  ///TODO: to remove
  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (!isRelease) {
      if (event.logicalKey == LogicalKeyboardKey.keyP) {
        debugPrint("pressed P: testing");
        blocParameters.gameBloc.add(const GamePause());
        //blocParameters.gameBloc.add(GameWin(_gameManager.currentLevelIndex));
        // SaveUtils.instance.addFreeAnimal(AnimalType.seal);
      }
      else if (event.logicalKey == LogicalKeyboardKey.keyO) {
        debugPrint("pressed O: testing");
        // blocParameters.gameBloc.add(const GameResume());
        // FlameAudio.play(pathSfxGameOver);
        debugPrint(SaveUtils.instance
            .getFreedAnimalIndex()
            .length
            .toString());
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }

}
