
enum TrashType
{
  any,
  bagTrash,
  cutleries,
  plasticCup,
  straw,
  styroFoam,
  waterBottle,
  waterGallon,
}

enum AnimalType
{
  crab,
  seaTurtle,
  dolphin,
  whale,
}

enum LevelType
{
  normal,
  boss,
}

class TrashObjective
{
  final TrashType trashType;
  final int goal;
  /// TimeLimit in seconds.
  final double timeLimit;

  const TrashObjective({
    required this.trashType,
    required this.goal,
    required this.timeLimit,
  });
}

class SharkConfig
{
  final double speed;
  final int count;
  const SharkConfig({this.speed = 100,this.count = 0});
}

class LevelParameters
{
  final List<TrashObjective> trashObjectives;
  final Map<AnimalType,TrashObjective>? trappedAnimals;
  final LevelType levelType;
  final SharkConfig sharkConfig;

  final double playerSpeed;
  final double trashSpeed;
  final double animalTrashChance;
  final double trashSpawnMin;
  final double trashSpawnMax;
  final int octopusCount;

  LevelParameters({
    required this.trashObjectives,
    this.trappedAnimals,
    this.levelType = LevelType.normal,
    this.sharkConfig = const SharkConfig(),
    this.playerSpeed = 150,
    this.animalTrashChance = 0.6,
    this.trashSpeed = 0.5,
    this.trashSpawnMin = 1,
    this.trashSpawnMax = 15,
    this.octopusCount = 0});
}