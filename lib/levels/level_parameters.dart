
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
  seal,
  dolphin,
}

enum LevelType
{
  normal,
  boss,
}

class TrashObjective
{
  TrashType trashType;
  int goal;
  double timeLimit;

  TrashObjective({
    required this.trashType,
    required this.goal,
    required this.timeLimit,
  });
}

class LevelParameters
{
  List<TrashObjective> trashObjectives;
  Map<AnimalType,TrashObjective>? trappedAnimals;
  LevelType levelType;
  int sharkCount;
  int octopusCount;


  LevelParameters({required this.trashObjectives,this.trappedAnimals,this.levelType = LevelType.normal,this.sharkCount = 0,this.octopusCount = 0});
}