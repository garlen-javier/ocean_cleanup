
import 'package:equatable/equatable.dart';

import '../../core/game_result.dart';


enum GamePhase{
  none,
  start,
  playing,
  pause,
  gameOver,
  win,
  quit,
  suspended,
  error,
}

class GameState extends Equatable {

  final GamePhase phase;
  final int levelIndex;
  final int stageIndex;
  final GameResult? result;
  final String error;

  const GameState({
    required this.phase,
    required this.levelIndex,
    required this.stageIndex,
    required this.error,
    this.result,
  });

  const GameState.empty()
      : this(
    phase: GamePhase.none,
    levelIndex: 0,
    stageIndex: 0,
    result: null,
    error: "",
  );

  GameState copyWith({
    GamePhase? phase,
    int? levelIndex,
    int? stageIndex,
    String? error,
    GameResult? result,
  }) {
    return GameState(
      phase: phase ?? this.phase,
      levelIndex: levelIndex ?? this.levelIndex,
      stageIndex: stageIndex ?? this.stageIndex,
      error: error ?? this.error,
      result: result,
    );
  }

  @override
  List<Object?> get props => [phase,levelIndex,stageIndex];
}