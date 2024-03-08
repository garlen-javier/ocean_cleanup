

import 'package:flutter/foundation.dart';

import '../utils/utils.dart';
import 'level_parameters.dart';

class Levels
{
  static final Levels _instance = Levels.constructor();
  static Levels get instance => _instance;

  List<LevelParameters> params = [];

  Levels.constructor()
  {
    params.add(_level1());
    params.add(_level2());
    params.add(_level3());
    params.add(_level4());
    params.add(_level5());
  }

  LevelParameters _level1()
  {
    TrashObjective mainMission = TrashObjective(
        trashType: TrashType.any,
        goal: 25,
        timeLimit: Utils.minuteToSeconds(1.5));

    List<TrashObjective> objectives = [mainMission];
    SharkConfig sharkConfig = const SharkConfig(count: 2);
    return LevelParameters(
        trashSpawnMin: 1,
        trashSpawnMax: 20,
        trashObjectives: objectives,sharkConfig: sharkConfig);
  }

  LevelParameters _level2()
  {
    TrashObjective mainMission = TrashObjective(
        trashType: TrashType.any,
        goal: 35,
        timeLimit: Utils.minuteToSeconds(2));

    TrashObjective animalMission = TrashObjective(
        trashType: TrashType.plasticCup,
        goal: 8,
        timeLimit: Utils.minuteToSeconds(1));

    Map<AnimalType,TrashObjective> trappedAnimals = {
      AnimalType.crab: animalMission,
    };

    List<TrashObjective> objectives = [mainMission];
    SharkConfig sharkConfig = const SharkConfig(count: 3);
    return LevelParameters(
      animalTrashChance: 0.3,
        trashObjectives: objectives,
        trappedAnimals: trappedAnimals,
        trashSpawnMin: 1,
        trashSpawnMax: 20,
        sharkConfig: sharkConfig);
  }

  LevelParameters _level3()
  {
    TrashObjective mainMission = TrashObjective(
        trashType: TrashType.any,
        goal: 40,
        timeLimit: Utils.minuteToSeconds(2.5));

    TrashObjective animalMission = TrashObjective(
        trashType: TrashType.bagTrash,
        goal: 10,
        timeLimit: Utils.minuteToSeconds(1));

    Map<AnimalType,TrashObjective> trappedAnimals = {
      AnimalType.seaTurtle: animalMission,
    };

    List<TrashObjective> objectives = [mainMission];
    SharkConfig sharkConfig = const SharkConfig(count: 4,speed: 110);
    return LevelParameters(
      animalTrashChance: 0.3,
        trashObjectives:objectives,
        trappedAnimals:trappedAnimals,
        trashSpawnMin: 1,
        trashSpawnMax: 20,
        sharkConfig: sharkConfig);
  }

  LevelParameters _level4()
  {
    TrashObjective mainMission = TrashObjective(
        trashType: TrashType.any,
        goal: 50,
        timeLimit: Utils.minuteToSeconds(3));

    TrashObjective animalMission1 = TrashObjective(
        trashType: TrashType.styroFoam,
        goal: 7,
        timeLimit: Utils.minuteToSeconds(1.5));

    TrashObjective animalMission2 = TrashObjective(
        trashType: TrashType.plasticCup,
        goal: 8,
        timeLimit: Utils.minuteToSeconds(1.5));

    Map<AnimalType,TrashObjective> trappedAnimals = {
      AnimalType.dolphin: animalMission1,
      AnimalType.whale: animalMission2,
    };

    List<TrashObjective> objectives = [mainMission];
    SharkConfig sharkConfig = const SharkConfig(count: 4,speed: 120);
    return LevelParameters(
        animalTrashChance: 0.3,
        trashObjectives: objectives,
        trappedAnimals:trappedAnimals,
        trashSpawnMin: 1,
        trashSpawnMax: 20,
        sharkConfig: sharkConfig);
  }

  LevelParameters _level5()
  {
    TrashObjective stage1 = const TrashObjective(
        trashType: TrashType.waterBottle,
        goal: 12,
        timeLimit:  45);

    TrashObjective stage2 = const TrashObjective(
        trashType: TrashType.styroFoam,
        goal: 12,
        timeLimit:  40);

    TrashObjective stage3 = const TrashObjective(
        trashType: TrashType.plasticCup,
        goal: 12,
        timeLimit:  35);

    TrashObjective stage4 = const TrashObjective(
        trashType: TrashType.waterGallon,
        goal: 12,
        timeLimit:  30);

    TrashObjective stage5 = const TrashObjective(
        trashType: TrashType.bagTrash,
        goal: 12,
        timeLimit:  30);

    List<TrashObjective> objectives = [stage1,stage2,stage3,stage4,stage5];
    SharkConfig sharkConfig = const SharkConfig(count: 4,speed: 120);
    return LevelParameters(
        mainTrashChance: 0.3,
        trashObjectives: objectives,
        sharkConfig: sharkConfig,
        trashSpawnMin: 1,
        trashSpawnMax: 20,
        levelType: LevelType.boss,
        octopusCount: 1);
  }

  void createTestLevel(
      double playerSpeed,
      double trashSpeed,
      double animalTrashChance,
      double trashSpawnMin,
      double trashSpawnMax,
      double sharkSpeed,
      int sharkCount,
      TrashObjective mainMission,
      TrashObjective animalMission)
  {
    params.clear();
    Map<AnimalType,TrashObjective> trappedAnimals = {
      AnimalType.whale: animalMission,
    };

    List<TrashObjective> objectives = [mainMission];
    SharkConfig sharkConfig = SharkConfig(speed: sharkSpeed, count: sharkCount);
    LevelParameters levelParam =  LevelParameters(
        playerSpeed: playerSpeed,
        trashSpeed: trashSpeed,
        animalTrashChance: animalTrashChance,
        trashSpawnMin: trashSpawnMin,
        trashSpawnMax: trashSpawnMax,
        trashObjectives: objectives,
        trappedAnimals: trappedAnimals,
        sharkConfig: sharkConfig);
    params.add(levelParam);
  }

}