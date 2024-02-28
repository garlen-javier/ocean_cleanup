
import 'package:equatable/equatable.dart';
import '../../constants.dart';
import '../../levels/level_parameters.dart';


class GameStatsState extends Equatable {
  final AnimalType? freedAnimal;
  final TrashType trashType;
  final int trashCount;
  final int health;
  final bool timerFinish;
  final bool rescueFailed;

   const GameStatsState({
     this.freedAnimal,
     this.trashType = TrashType.any,
     this.trashCount = 0,
     this.health = defaultHealth,
     this.timerFinish = false,
     this.rescueFailed = false,
  });

  const GameStatsState.empty() : this(freedAnimal: null, trashType:TrashType.any,trashCount:0, health: defaultHealth,timerFinish:false, rescueFailed: false);

  GameStatsState copyWith({
    AnimalType? freedAnimal,
    TrashType? trashType,
    int? trashCount,
    int? health,
    bool? timerFinish,
    bool? rescueFailed
  }) {
    return GameStatsState(
        freedAnimal: freedAnimal,
        trashType: trashType ?? this.trashType,
        trashCount: trashCount ?? this.trashCount,
        health: health ?? this.health,
        timerFinish: timerFinish ?? this.timerFinish,
        rescueFailed: rescueFailed ?? this.rescueFailed);
  }

  @override
  List<Object?> get props => [freedAnimal,trashType,trashCount,health,timerFinish,rescueFailed];
}

