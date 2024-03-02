

import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ocean_cleanup/components/hud/hud_mobile_control.dart';
import 'package:ocean_cleanup/utils/utils.dart';
import '../bloc/game_bloc_parameters.dart';
import '../bloc/game_stats/game_stats_barrel.dart';
import '../components/hud/hud_stats.dart';
import '../components/hud/hud_timer.dart';
import '../components/player/player_controller.dart';
import '../constants.dart';
import '../core/game_manager.dart';
import '../levels/level_parameters.dart';
import '../mixins/update_mixin.dart';
import '../scenes/game_scene.dart';
import 'package:flutter/material.dart' as material;

class HudWorld extends World with HasUpdateMixin,HasGameRef<GameScene>
{
  final GameManager gameManager;
  final GameBlocParameters blocParameters;
  final PlayerController? playerController;
  HudWorld({required this.gameManager, required this.blocParameters, this.playerController}):super();

  late Vector2 _gameSize;
  late HudStats? _hudStats;
  double remainingTime = 0;

  @override
  FutureOr<void> onLoad() async{
    _gameSize = gameRef!.size;
    if (Utils.isMobile)
      await _showMobileControl();
    await _showTimer();
    await _showGameStats();
    if(!isRelease)
       await _showFPSDisplay();
    return super.onLoad();
  }

  Future<void> _showTimer() async {
    //TODO: testing
    LevelParameters params = gameManager.currentLevelParams;
    double timeLimit = params.trashObjectives.elementAt(0).timeLimit;
    double? animalTimeLimit = params.trappedAnimals?.values.first.timeLimit;
    //double timeLimit = 10;
   // double? animalTimeLimit = 10;
    await add(HudTimer(
        timeLimit: timeLimit,
        pos:Vector2(-20,-_gameSize.y * 0.48),
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

  Future<void> _showMobileControl() async {
    await add(HudMobileControl(blocParameters: blocParameters,playerController: playerController));
  }

  Future<void> _showFPSDisplay() async {
    await add(FpsTextComponent(
      textRenderer: TextPaint(
        style: const material.TextStyle(color: material.Colors.black, fontSize: 20),
      ),
       position: Vector2(_gameSize.x * 0.35,_gameSize.y * 0.4),
    ));
  }

  Future<void> _showGameStats() async {
    _hudStats = HudStats(
        health: gameManager.health,
        trappedAnimals: gameManager.trappedAnimalsMap,
        trashTypes: gameManager.currentTrashTypes);

    //await add(stats);
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<GameStatsBloc, GameStatsState>.value(
            value: blocParameters.gameStatsBloc,
          ),
        ],
        children: [
          _hudStats!,
        ],
      ),
    );
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

    if(_hudStats != null)
        _hudStats!.runUpdate(dt);

  }

  @override
  void onGameResize(Vector2 size) {
    _gameSize = size;
    super.onGameResize(size);
  }

  @override
  void onRemove() {
    _hudStats = null;
    super.onRemove();
  }


}