
import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:ocean_cleanup/components/hud/hud_trash_count.dart';
import 'package:ocean_cleanup/constants.dart';
import 'package:ocean_cleanup/mixins/update_mixin.dart';
import '../../bloc/game_stats/game_stats_barrel.dart';
import '../../levels/level_parameters.dart';
import '../../core/game_scene.dart';
import 'animal_timer/hud_animal_timer.dart';

class HudStats extends PositionComponent with HasGameRef<GameScene>,UpdateMixin
{
  int health;
  final Map<AnimalType, TrashObjective>? trappedAnimals;
  TrashType trashType;
  final int totalTrash;
  HudStats({required this.health, required this.trappedAnimals,required this.trashType, required this.totalTrash});

  late Vector2 _gameSize;
  late HudTrashCount _trashCounter;
  final List<SpriteComponent> _healthIcons = [];

  @override
  FutureOr<void> onLoad() async{
    _gameSize = screenRatio.toVector2();

    await _loadHealth(80);
    await _loadTrashCounter(62);
    await _loadTrappedAnimals(15);
    await _initBlocListener();
    return super.onLoad();
  }

  Future<void> _initBlocListener() async {
    await add(
      FlameBlocListener<GameStatsBloc, GameStatsState>(
        listenWhen: (previousState, newState) {
          return previousState.health != newState.health;
        },
        onNewState: (state) {
          _updateHealthWithState(state);
        },
      ),
    );
  }

  Future<void> _loadHealth(int marginX) async {
    int currentHealth = health;
    var sprite = Sprite(gameRef.images.fromCache(pathHealth));

    const int rowCount = 2;
    const int colCount = 5;
    const double rowSpacing = 20;
    const double columnSpacing = 25;

    Vector2 initialPos = Vector2(-_gameSize.x * 0.28,-_gameSize.y * 0.23);
    _healthIcons.clear();
    for (int i = 0; i < rowCount * colCount; ++i) {
      int row = i ~/ colCount;
      int col = i % colCount;

      Vector2 iconPos = initialPos + Vector2(col * columnSpacing, row * rowSpacing);
      if (i < maxHealth) {
        SpriteComponent healthIcon = SpriteComponent(
          sprite: sprite,
          anchor: Anchor.center,
          position: iconPos,
        );
        await add(healthIcon);
        _healthIcons.add(healthIcon);
      }

      if (i >= currentHealth && i < maxHealth) {
        _healthIcons[i].opacity = 0;
      }

    }
  }

  void _updateHealthWithState(GameStatsState state)
  {
    for(int i = 0;i < _healthIcons.length; ++i)
    {
      _healthIcons[i].opacity = 1;
      if(i >= state.health)
      {
        _healthIcons[i].opacity = 0;
      }
    }
  }

  Future<void> _loadTrashCounter(int marginX) async {
    int count =  1 + trappedAnimals!.length;
    double totalWidth = (marginX  * (count - 1) ) + 27;
    double initialX = -totalWidth * 0.5;

    Vector2 counterPos = Vector2(initialX, -_gameSize.y * 0.23);
    _trashCounter = HudTrashCount(trashType: trashType,totalTrash: totalTrash, position: counterPos);
    await add(_trashCounter);
    counterPos = Vector2(_trashCounter.x + marginX, _trashCounter.y);

    for (var entry in trappedAnimals!.entries) {
      TrashObjective mission = entry.value;
      var missionCounter = HudTrashCount(trashType: mission.trashType,totalTrash: mission.goal, position: counterPos);
      await add(missionCounter);
      counterPos = Vector2(missionCounter.x + marginX, missionCounter.y);
    }
  }

  void setNewTrashGoal(TrashType type,int total)
  {
    _trashCounter.setTrash(type, total);
    _trashCounter.resetCount();
  }

  Future<void> _loadTrappedAnimals(int marginX) async {
    if(trappedAnimals == null)
      return;

    if(trappedAnimals!.isNotEmpty) {
      var image = gameRef.images.fromCache(pathRescueComplete);
      int count = trappedAnimals!.length;
      int elementWidth = image.width;

      Vector2 counterPos  = Vector2((_gameSize.x * 0.33 - (count * elementWidth)), -_gameSize.y * 0.2);

      for (var entry in trappedAnimals!.entries) {
        AnimalType animal = entry.key;
        TrashObjective mission = entry.value;

        var timer = HudAnimalTimer(position: counterPos,
            animalType: animal,
            maxDuration: mission.timeLimit);
        await add(timer);
        counterPos = Vector2(timer.x + elementWidth + marginX, timer.y);
      }
    }
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
  }

}