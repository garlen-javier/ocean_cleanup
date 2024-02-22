

import '../utils/utils.dart';
import 'level_parameters.dart';

class Levels
{
  List<LevelParameters> params = [];

  Levels()
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
        timeLimit: Utils.minuteToSeconds(2));

    
    List<TrashObjective> objectives = [mainMission];
    return LevelParameters(trashObjectives: objectives,sharkCount: 2);
  }

  LevelParameters _level2()
  {
    TrashObjective mainMission = TrashObjective(
        trashType: TrashType.any,
        goal: 33,
        timeLimit: Utils.minuteToSeconds(2.5));

    TrashObjective animalMission = TrashObjective(
        trashType: TrashType.plasticCup,
        goal: 5,
        timeLimit: Utils.minuteToSeconds(1));

    Map<TrappedAnimal,TrashObjective> trappedAnimals = {
      TrappedAnimal.crab: animalMission,
    };

    List<TrashObjective> objectives = [mainMission];
    return LevelParameters(trashObjectives: objectives,trappedAnimals: trappedAnimals, sharkCount: 3);
  }

  LevelParameters _level3()
  {
    TrashObjective mainMission = TrashObjective(
        trashType: TrashType.any,
        goal: 40,
        timeLimit: Utils.minuteToSeconds(3));

    TrashObjective animalMission = TrashObjective(
        trashType: TrashType.bagTrash,
        goal: 7,
        timeLimit: Utils.minuteToSeconds(1));

    Map<TrappedAnimal,TrashObjective> trappedAnimals = {
      TrappedAnimal.seaTurtle: animalMission,
    };

    List<TrashObjective> objectives = [mainMission];
    return LevelParameters(trashObjectives:objectives,trappedAnimals:trappedAnimals,sharkCount: 4);
  }

  LevelParameters _level4()
  {
    TrashObjective mainMission = TrashObjective(
        trashType: TrashType.any,
        goal: 50,
        timeLimit: Utils.minuteToSeconds(3.5));

    TrashObjective animalMission1 = TrashObjective(
        trashType: TrashType.styroFoam,
        goal: 6,
        timeLimit: Utils.minuteToSeconds(1));

    TrashObjective animalMission2 = TrashObjective(
        trashType: TrashType.plasticCup,
        goal: 8,
        timeLimit: Utils.minuteToSeconds(1));

    Map<TrappedAnimal,TrashObjective> trappedAnimals = {
      TrappedAnimal.seal: animalMission1,
      TrappedAnimal.dolphin: animalMission2,
    };

    List<TrashObjective> objectives = [mainMission];
    return LevelParameters(trashObjectives: objectives,trappedAnimals:trappedAnimals,sharkCount: 5);
  }

  LevelParameters _level5()
  {
    TrashObjective stage1 = TrashObjective(
        trashType: TrashType.waterBottle,
        goal: 12,
        timeLimit:  45);

    TrashObjective stage2 = TrashObjective(
        trashType: TrashType.styroFoam,
        goal: 12,
        timeLimit:  40);

    TrashObjective stage3 = TrashObjective(
        trashType: TrashType.plasticCup,
        goal: 12,
        timeLimit:  35);

    TrashObjective stage4 = TrashObjective(
        trashType: TrashType.waterGallon,
        goal: 12,
        timeLimit:  30);

    TrashObjective stage5 = TrashObjective(
        trashType: TrashType.waterGallon,
        goal: 12,
        timeLimit:  30);

    List<TrashObjective> objectives = [stage1,stage2,stage3,stage4,stage5];
    return LevelParameters(trashObjectives: objectives,sharkCount: 5);
  }

}