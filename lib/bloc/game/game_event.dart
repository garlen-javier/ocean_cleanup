
import 'package:equatable/equatable.dart';

import '../../core/game_result.dart';


abstract class GameEvent extends Equatable {
  const GameEvent();
}

class GameStart extends GameEvent {

  final int levelIndex;
  final int stageIndex;
  const GameStart({required this.levelIndex,this.stageIndex = 0});

  @override
  List<Object?> get props => [];
}

class GameRestart extends GameEvent {
  const GameRestart();

  @override
  List<Object?> get props => [];
}

class GameStartNext extends GameEvent {
  const GameStartNext();

  @override
  List<Object?> get props => [];
}

class GamePlaying extends GameEvent {
  const GamePlaying();

  @override
  List<Object?> get props => [];
}

class GamePause extends GameEvent {
  const GamePause();

  @override
  List<Object?> get props => [];
}

class GameResume extends GameEvent {
  const GameResume();

  @override
  List<Object?> get props => [];
}

///Call this if you need to suspend the state of the game instead of just pausing it.
class GameSuspend extends GameEvent {
  const GameSuspend();

  @override
  List<Object?> get props => [];
}

abstract class GameFinish extends GameEvent {
  final GameResult result;
  const GameFinish(this.result);

  @override
  List<Object?> get props => [];
}

class GameOver extends GameFinish {
  const GameOver(super.result);

  @override
  List<Object?> get props => [];
}

class GameWin extends GameFinish {
  const GameWin(super.result);

  @override
  List<Object?> get props => [];
}

class GameQuit extends GameEvent {
  const GameQuit();

  @override
  List<Object?> get props => [];
}

///Call inside onRemove
class Default extends GameEvent {
  const Default();

  @override
  List<Object?> get props => [];
}
