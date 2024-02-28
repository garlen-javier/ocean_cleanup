
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
  late SpriteComponent? _complete;
  bool _isAnimalFree = false;

  @override
  FutureOr<void> onLoad() async {
    await _initDisplay();
    await _initBlocListener();
    return super.onLoad();
  }

  Future<void> _initDisplay() async {
    var sprite = Sprite(gameRef.images.fromCache(pathRescueComplete));
    _complete = SpriteComponent(
      sprite: sprite,
      anchor: Anchor.center,
      position: Vector2.zero(),
    );

    await add(_radialProgess = RadialProgress(
      maxDuration: maxDuration,
      size: sprite.srcSize,
      position: Vector2(2.5,2.5),
      strokeWidth: 8,
    ));
    await add(AnimalSprite(type: animalType, position: Vector2.zero(),));

    //await add(complete);
  }

  Future<void> _initBlocListener() async {
    await add(
      FlameBlocListener<GameStatsBloc, GameStatsState>(
        listenWhen: (previousState, newState) {
          return previousState.freedAnimal != newState.freedAnimal;
        },
        onNewState: (state) async {
          if(state.freedAnimal != null)
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
    _radialProgess?.removeFromParent();
    _radialProgess = null;
    await add(_complete!);
  }

  @override
  void runUpdate(double dt) {
    if(_radialProgess != null)
      _radialProgess!.runUpdate(dt);
  }

  @override
  void onRemove() {
    _radialProgess = null;
    _complete = null;
    super.onRemove();
  }

}