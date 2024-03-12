

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
import 'package:ocean_cleanup/core/audio_manager.dart';
import 'package:ocean_cleanup/core/game_manager.dart';
import 'package:ocean_cleanup/utils/save_utils.dart';
import '../bloc/game/game_barrel.dart';
import '../bloc/game_bloc_parameters.dart';
import '../bloc/game_stats/game_stats_barrel.dart';
import '../constants.dart';
import '../mixins/update_mixin.dart';
import '../worlds/game_world.dart';

class GameScene extends FlameGame with HasKeyboardHandlerComponents{

  final GameBlocParameters blocParameters;
  final int levelIndex;

  GameScene({
    required this.levelIndex,
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
    await _loadGameManager();
    await _loadGame();
    blocParameters.gameBloc.add(GameStart(levelIndex:levelIndex));
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
      pathOctopus,
      pathBagTrash,
      pathCutleries,
      pathPlasticCup,
      pathStraw,
      pathStyrofoam,
      pathWaterBottle,
      pathWaterGallon,
      pathCrab,
      pathTurtle,
      pathDolphin,
      pathWhale,
      pathFishNet,
      pathHealth,
      pathRescueComplete,
      pathRescueFailed,
      pathAnimalFrame,
      pathJoystickBase,
      pathJoystickKnob,
      pathCatchButtonDefault,
      pathCatchButtonPressed,
      pathPauseButton,
      pathPlayButton,
      pathBubble,
      pathMeterBar,
      pathMeterHolder,
      pathLightning,
    ]);

    await FlameAudio.audioCache.loadAll([
      pathBgmGame,
      pathBgmOctopus,
      pathSfxCatchTrash,
      pathSfxSwingNet,
      pathSfxReduceHealth,
      pathSfxGameOver,
      pathSfxLevelWin,
      pathSfxAnimalRescued,
      pathSfxLightning,
    ]);
  }

  Future<void> _loadCameras() async {
    gameCamera = CameraComponent.withFixedResolution(
      width: GameWorld.worldSize.width,
      height: GameWorld.worldSize.height,
    );

    gameCamera.viewfinder
      ..zoom = 0.5
      ..position = Vector2(GameWorld.worldSize.width, GameWorld.worldSize.height);
    // ..anchor = Anchor.topLeft;

    hudCamera = CameraComponent.withFixedResolution(
      width: screenRatio.width,
      height: screenRatio.height,
    );
    hudCamera.viewfinder.scale = Vector2.all(1.5);

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
    super.update(dt);
    if(hasChildren) {
      for (var child in children) {
        if(child is HasUpdateMixin){
          if(_gameManager.gamePhase == GamePhase.playing) {
            (child as dynamic)?.runUpdate(dt);
          }
        }
      }
    }
  }


  @override
  void onRemove() {
    debugPrint("FlameGame: onRemove");
    blocParameters.gameBloc.add(const Default());
    blocParameters.gameStatsBloc.defaultState();
    super.onRemove();
  }

  @override
  void onDispose() async {
    debugPrint("FlameGame: onDispose");
    AudioManager.instance.stopBgm();
    blocParameters.gameBloc.close();
    blocParameters.gameStatsBloc.close();
    //FlameAudio.audioCache.clearAll();
    //Flame.images.clearCache();
    //Flame.assets.clearCache();
    //TiledAtlas.clearCache();
    super.onDispose();
  }

  ///TODO: To Remove, For testing only
  bool isPress = false;
  bool isPressO = false;
  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (!isRelease) {
      final isKeyDown = event is RawKeyDownEvent;
      final isKeyUp = event is RawKeyUpEvent;

      if (event.logicalKey == LogicalKeyboardKey.keyP) {
        if(isKeyDown) {
          debugPrint("pressed P: testing");
          if(!isPress) {
            //_gameManager.nextStage();
            _gameManager.blocParameters.gameBloc.add(const GamePause());
            //_gameManager.blocParameters.gameBloc.add(GameStartNext());
            isPress = true;
          }
        }
        else if(isKeyUp){
          isPress = false;
        }
      }
      else if (event.logicalKey == LogicalKeyboardKey.keyO) {
        if(isKeyDown) {
          debugPrint("pressed O: testing");
          if(!isPressO) {
            _gameManager.blocParameters.gameBloc.add(const GameResume());
           // FlameAudio.bgm.stop();
            isPressO = true;
          }
        }
        else if(isKeyUp){
          isPressO = false;
        }
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }

}
