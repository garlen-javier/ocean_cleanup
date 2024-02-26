

import 'package:equatable/equatable.dart';

enum GamePhase{
  none,
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
  final String error;

  const GameState({
    required this.phase,
    required this.levelIndex,
    required this.error,
  });

  const GameState.empty()
      : this(
    phase: GamePhase.none,
    levelIndex: 0,
    error: "",
  );

  GameState copyWith({
    GamePhase? phase,
    int? levelIndex,
    String? error,
  }) {
    return GameState(
      phase: phase ?? this.phase,
      levelIndex: levelIndex ?? this.levelIndex,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [phase,levelIndex];
}