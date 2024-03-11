

import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:ocean_cleanup/bloc/game/game_barrel.dart';
import 'package:ocean_cleanup/components/hud/hud_mobile_control.dart';
import '../bloc/game_bloc_parameters.dart';
import '../bloc/game_stats/game_stats_barrel.dart';
import '../components/hud/hud_octopus_meter.dart';
import '../components/hud/hud_pause_button.dart';
import '../components/hud/hud_stats.dart';
import '../components/hud/hud_timer.dart';
import '../components/player/player_controller.dart';
import '../constants.dart';
import '../core/game_manager.dart';
import '../levels/level_parameters.dart';
import '../mixins/update_mixin.dart';
import '../core/game_scene.dart';
import 'package:flutter/material.dart' as material;

import '../utils/utils.dart';

class HudWorld extends World with HasUpdateMixin,HasGameRef<GameScene>
{
  final GameManager gameManager;
  final GameBlocParameters blocParameters;
  final PlayerController? playerController;
  HudWorld({required this.gameManager, required this.blocParameters, this.playerController}):super();

  late Vector2 _gameSize;
  late HudStats? _hudStats;

  HudTimer? _hudTimer;
  HudPauseButton? _pauseButton;
  HudOctopusMeter? _octopusMeter;
  double remainingTime = 0;

  @override
  FutureOr<void> onLoad() async{
    _gameSize = screenRatio.toVector2();
    if (Utils.isMobile)
      await _showMobileControl();
    if(!isRelease)
       await _showFPSDisplay();
    await _showTimer();
    await _showGameStats();
    await _showPauseButton();
    await _showOctopusMeter();
    await _addBlocProvider();
    return super.onLoad();
  }

  Future<void> _addBlocProvider() async {
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<GameStatsBloc, GameStatsState>.value(
            value: blocParameters.gameStatsBloc,
          ),
          FlameBlocProvider<GameBloc, GameState>.value(
            value: blocParameters.gameBloc,
          ),
        ],
        children: [
          _hudStats!,
          _pauseButton!,
        ],
      ),
    );
  }

  Future<void> _showTimer() async {
    LevelParameters params = gameManager.currentLevelParams;
    double timeLimit = gameManager.currentTrashObjective.timeLimit;
    double? animalTimeLimit = params.trappedAnimals?.values.first.timeLimit;
    await add(_hudTimer = HudTimer(
        initialLimit: timeLimit,
        position:Vector2(-20,-_gameSize.y * 0.3),
        remainingTime: (time,countdown) {
          remainingTime = time;
          if(animalTimeLimit != null)
          {
            if(countdown >= animalTimeLimit)
              blocParameters.gameStatsBloc.rescueFailed();
          }
        },
        timerFinished: () {
          blocParameters.gameStatsBloc.timerFinish();
        }
    ));
  }

  void startNewTimeLimit(double timeLimit)
  {
     _hudTimer?.setTimeLimit(timeLimit);
     _hudTimer?.start();
  }

  void startNewTrashGoal(TrashType type,int total)
  {
    _hudStats?.setNewTrashGoal(type, total);
  }

  Future<void> _showMobileControl() async {
    await add(HudMobileControl(blocParameters: blocParameters,playerController: playerController));
  }

  Future<void> _showFPSDisplay() async {
    await add(FpsTextComponent(
      textRenderer: TextPaint(
        style: const material.TextStyle(color: material.Colors.black, fontSize: 20),
      ),
       position: Vector2(_gameSize.x * 0.24,_gameSize.y * 0.255),
    ));
  }

  Future<void> _showGameStats() async {
    _hudStats = HudStats(
        health: gameManager.initialHealth,
        trappedAnimals: gameManager.trappedAnimalsMap,
        trashType: gameManager.currentTrashObjective.trashType,
        totalTrash: gameManager.currentTrashObjective.goal);
  }

  Future<void> _showPauseButton() async {
    SpriteComponent defaultSkin = SpriteComponent(sprite: Sprite(gameRef.images.fromCache(pathPauseButton),));
    SpriteComponent selectedSkin = SpriteComponent(sprite: Sprite(gameRef.images.fromCache(pathPlayButton),));
    _pauseButton = HudPauseButton(
      defaultSkin:  defaultSkin,
      selectedSkin: selectedSkin,
      position: Vector2(_gameSize.x * 0.29 , -_gameSize.y * 0.28),
      onPressDown:(button) {
        if(gameManager.gamePhase == GamePhase.playing)
        {
          button.toggle();
          blocParameters.gameBloc.add(const GamePause());
        }
        else if(gameManager.gamePhase == GamePhase.pause)
        {
          button.toggle();
          blocParameters.gameBloc.add(const GameResume());
        }
      },);
  }

  Future<void> _showOctopusMeter() async {
    if(gameManager.currentLevelParams.levelType == LevelType.boss)
    {
      LevelParameters params = gameManager.currentLevelParams;
      _octopusMeter = HudOctopusMeter(
          stageIndex: gameManager.currentStageIndex,
          totalStageNum: params.trashObjectives.length,
          timeLimit: gameManager.currentTrashObjective.timeLimit,
          position: Vector2(_gameSize.x * 0.27 , -_gameSize.y * 0.23));

      await add(_octopusMeter!);
    }
  }

  void updateOctopusMeterWithStage(int stageIndex,double limit)
  {
    _octopusMeter?.updateLimitWithStage(stageIndex, limit);
  }

  void updateOctopusMeterValue(double value)
  {
    _octopusMeter?.changeBarPercent(value);
  }

  @override
  void runUpdate(double dt) {
    if(hasChildren) {
      for (var child in children) {
        if(child is UpdateMixin){
          (child as dynamic)?.runUpdate(dt);
        }
      }
    }

    if(_hudStats != null)
        _hudStats!.runUpdate(dt);
  }

  @override
  void onRemove() {
    _hudTimer = null;
    _hudStats = null;
    _pauseButton = null;
    super.onRemove();
  }

}