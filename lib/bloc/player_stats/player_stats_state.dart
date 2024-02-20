
import 'package:equatable/equatable.dart';
import 'package:flame/components.dart';


class PlayerStatsState extends Equatable {
  final int score;
  final int health;
   const PlayerStatsState({
     this.score = 0, this.health = 0,
  });

  const PlayerStatsState.empty() : this(score: 0, health: 0);

  PlayerStatsState copyWith({
    int? score,
    int? health,
  }) {
    return PlayerStatsState(score: score ?? this.score, health: health ?? this.health);
  }

  @override
  List<Object?> get props => [score,health];
}

