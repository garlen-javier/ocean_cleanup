
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:ocean_cleanup/components/hud/animal_timer/animal_sprite.dart';
import 'package:ocean_cleanup/components/hud/animal_timer/radial_progress.dart';
import 'package:ocean_cleanup/levels/level_parameters.dart';
import '../../../bloc/game_stats/game_stats_bloc.dart';
import '../../../bloc/game_stats/game_stats_state.dart';
import '../../../constants.dart';
import '../../../mixins/update_mixin.dart';
import '../../../scenes/game_scene.dart';

class HudAnimalTimer extends PositionComponent with HasGameRef<GameScene>,UpdateMixin
{
  final AnimalType animalType;
  final double maxDuration;
  HudAnimalTimer({required this.animalType,required this.maxDuration,super.position});

  late RadialProgress? _radialProgess;
  late AnimalSprite? _animalSprite;
  bool _isAnimalFree = false;

  @override
  FutureOr<void> onLoad() async {
    await _initDisplay();
    await _initBlocListener();
    return super.onLoad();
  }

  Future<void> _initDisplay() async {
    var completeSp = Sprite(gameRef.images.fromCache(pathRescueComplete));
    await add(_radialProgess = RadialProgress(
      maxDuration: maxDuration,
      size: completeSp.srcSize,
      position: Vector2(2.5,2.5),
      strokeWidth: 8,
      onFinish: () {
        _showFailed();
      }
    ));

    await add(_animalSprite = AnimalSprite(type: animalType, position: Vector2.zero(),));
    //await add(complete);
  }

  Future<void> _initBlocListener() async {
    await add(
      FlameBlocListener<GameStatsBloc, GameStatsState>(
        listenWhen: (previousState, newState) {
          return previousState.freedAnimal != newState.freedAnimal;
        },
        onNewState: (state) async {
          if(state.freedAnimal != null && !state.rescueFailed)
          {
            if(!_isAnimalFree && animalType == state.freedAnimal) {
              _isAnimalFree = true;
              await _showComplete();
            }
          }
        },
      ),
    );
  }

  Future<void>  _showComplete() async {
    _removeAnimalDisplay();

    var completeSp = Sprite(gameRef.images.fromCache(pathRescueComplete));
    SpriteComponent complete = SpriteComponent(
      sprite: completeSp,
      anchor: Anchor.center,
      position: Vector2.zero(),
    );
    await add(complete);
  }

  Future<void> _showFailed() async {
    _removeAnimalDisplay();

    var failedSp = Sprite(gameRef.images.fromCache(pathRescueFailed));
    SpriteComponent failedComp = SpriteComponent(
      sprite: failedSp,
      anchor: Anchor.center,
      position: Vector2.zero(),
    );
    await add(failedComp);
  }

  void _removeAnimalDisplay()
  {
    _radialProgess?.removeFromParent();
    _animalSprite?.removeFromParent();
    _radialProgess = null;
    _animalSprite = null;
  }

  @override
  void runUpdate(double dt) {
    if(_radialProgess != null)
      _radialProgess!.runUpdate(dt);
  }

  @override
  void onRemove() {
    _radialProgess = null;
    _animalSprite = null;
    super.onRemove();
  }

}