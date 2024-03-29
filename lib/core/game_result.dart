


import '../levels/level_parameters.dart';
import '../utils/utils.dart';

class GameResult
{
  final int levelIndex;
  final int health;
  final int totalTrashCount;
  final int score;
  final double remainingTime; //in seconds
  final LevelType levelType;
  final List<AnimalType>? freedAnimal;

  GameResult({required this.levelIndex,
    required this.health,
    required this.totalTrashCount,
    required this.score,
    required this.remainingTime,
    required this.levelType,
    this.freedAnimal,
  });

  final StringBuffer _sb = StringBuffer();
  @override
  String toString() {
    _sb.clear();
    _sb.writeln("Level Type : $levelType");
    _sb.writeln("Level Index : $levelIndex");
    _sb.writeln("health : $health");
    _sb.writeln("total trash count : $totalTrashCount");
    _sb.writeln("score: $score");
    _sb.writeln("remainingTime : $remainingTime");
    _sb.writeln("formattedTime : ${Utils.formatTime(remainingTime.floorToDouble())}");
    if(freedAnimal != null)
    {
        freedAnimal!.forEach((element) {
          _sb.writeln("Freed Animal : $element");
        });
    }
    return _sb.toString();
  }
}