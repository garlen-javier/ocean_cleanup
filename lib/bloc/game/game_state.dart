
import 'package:equatable/equatable.dart';

import '../../core/game_result.dart';


enum GamePhase{
  none,
  ready,
  playing,
  pause,
  gameOver,
  win,
  quit,
  error,
}

class GameState extends Equatable {

  final GamePhase phase;
  final int levelIndex;
  final GameResult? result;
  final String error;

  const GameState({
    required this.phase,
    required this.levelIndex,
    required this.error,
    this.result,
  });

  const GameState.empty()
      : this(
    phase: GamePhase.none,
    levelIndex: 0,
    result: null,
    error: "",
  );

  GameState copyWith({
    GamePhase? phase,
    int? levelIndex,
    String? error,
    GameResult? result,
  }) {
    return GameState(
      phase: phase ?? this.phase,
      levelIndex: levelIndex ?? this.levelIndex,
      error: error ?? this.error,
      result: result,
    );
  }

  @override
  List<Object?> get props => [phase,levelIndex];
}