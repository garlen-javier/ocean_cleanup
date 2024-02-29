
import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:ocean_cleanup/components/hud/hud_trash_count.dart';
import 'package:ocean_cleanup/constants.dart';
import 'package:ocean_cleanup/mixins/update_mixin.dart';
import '../../bloc/game_stats/game_stats_barrel.dart';
import '../../levels/level_parameters.dart';
import '../../scenes/game_scene.dart';
import 'animal_timer/hud_animal_timer.dart';

class HudStats extends PositionComponent with HasGameRef<GameScene>,UpdateMixin
{
  int health;
  final Map<AnimalType, TrashObjective>? trappedAnimals;
  final Set<TrashType> trashTypes;
  HudStats({required this.health, required this.trappedAnimals, required this.trashTypes});

  late Vector2 _gameSize;
  final List<SpriteComponent> _healthIcons = [];

  @override
  FutureOr<void> onLoad() async{
    _gameSize = gameRef!.size;

    await _loadHealth(80);
    await _loadTrashCounter(60);
    await _loadTrappedAnimals(15);
    await _initBlocListener();
    return super.onLoad();
  }

  Future<void> _initBlocListener() async {
    await add(
      FlameBlocListener<GameStatsBloc, GameStatsState>(
        listenWhen: (previousState, newState) {
          return true;
        },
        onNewState: (state) {
          _updateHealthWithState(state);
        },
      ),
    );
  }

  Future<void> _loadHealth(int marginX) async {
    int count = health;
    var sprite = Sprite(gameRef.images.fromCache(pathHealth));

    const int rowCount = 2;
    const int colCount = 5;
    const double rowSpacing = 20;
    const double columnSpacing = 25;

    Vector2 initialPos = Vector2(-_gameSize.x * 0.43, -_gameSize.y * 0.35);
    _healthIcons.clear();
    for (int i = 0; i < rowCount * colCount; ++i) {
      int row = i ~/ colCount;
      int col = i % colCount;

      Vector2 iconPos = initialPos + Vector2(col * columnSpacing, row * rowSpacing);
      if (i < count) {
        SpriteComponent healthIcon = SpriteComponent(
          sprite: sprite,
          anchor: Anchor.center,
          position: iconPos,
        );
        await add(healthIcon);
        _healthIcons.add(healthIcon);
      }
    }
  }

  void _updateHealthWithState(GameStatsState state)
  {
    for(int i = 0;i < _healthIcons.length; ++i)
    {
      if(i >= state.health)
      {
        _healthIcons[i].opacity = 0;
      }
    }
  }

  Future<void> _loadTrashCounter(int marginX) async {
    int count = trashTypes.length;

    Vector2 counterPos = Vector2(-_gameSize.x * 0.12 * (count-1)/count,-_gameSize.y * 0.35);
    for(int i = 0; i < count ; ++i)
    {
      var trashCounter = HudTrashCount(trashType: trashTypes.elementAt(i), position: counterPos);
      await add(trashCounter);
      counterPos = Vector2(trashCounter.x + marginX,trashCounter.y);
    }
  }

  Future<void> _loadTrappedAnimals(int marginX) async {
    if(trappedAnimals == null)
      return;

    var image = gameRef.images.fromCache(pathRescueComplete);
    int count = trappedAnimals!.length;
    int elementWidth = image.width;
    Vector2 counterPos = Vector2(_gameSize.x  * 0.5 - (count * elementWidth), -_gameSize.y * 0.35);

    for(var entry in trappedAnimals!.entries)
    {
      AnimalType animal = entry.key;
      TrashObjective mission = entry.value;

      var timer = HudAnimalTimer(position: counterPos, animalType: animal, maxDuration: mission.timeLimit);
      await add(timer);
      counterPos = Vector2(timer.x + elementWidth + marginX,timer.y);
    }

  }

  @override
  void onGameResize(Vector2 size) {
    _gameSize = size;
    super.onGameResize(size);
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
  }

}