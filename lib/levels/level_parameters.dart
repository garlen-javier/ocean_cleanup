
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

enum TrappedAnimal
{
  crab,
  seaTurtle,
  seal,
  dolphin,
  whale
}

class TrashObjective
{
  TrashType trashType;
  int goal;
  int timeLimit;

  TrashObjective({
    required this.trashType,
    required this.goal,
    required this.timeLimit,
  });
}

class LevelParameters
{
  List<TrashObjective> trashObjectives;
  Map<TrappedAnimal,TrashObjective>? trappedAnimals;
  int sharkCount;
  int octopusCount;

  LevelParameters({required this.trashObjectives,this.trappedAnimals,this.sharkCount = 0,this.octopusCount = 0});
}