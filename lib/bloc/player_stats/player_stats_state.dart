
import 'package:equatable/equatable.dart';
import '../../levels/level_parameters.dart';


class PlayerStatsState extends Equatable {
  final TrashType trashType;
  final int trashCount;
  final int health;

   const PlayerStatsState({
     this.trashType = TrashType.any,
     this.trashCount = 0,
     this.health = 0,
  });

  const PlayerStatsState.empty() : this(trashType: TrashType.any,trashCount:0, health: 0);

  PlayerStatsState copyWith({
    TrashType? trashType,
    int? trashCount,
    int? health,
  }) {
    return PlayerStatsState(
        trashType: trashType ?? this.trashType,
        trashCount: trashCount ?? this.trashCount,
        health: health ?? this.health);
  }

  @override
  List<Object?> get props => [trashType,trashCount,health];
}

