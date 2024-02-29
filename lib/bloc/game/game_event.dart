
import 'package:equatable/equatable.dart';

import '../../core/game_result.dart';


abstract class GameEvent extends Equatable {
  const GameEvent();
}

class GameReady extends GameEvent {
  const GameReady();

  @override
  List<Object?> get props => [];
}

class GameStart extends GameEvent {

  final int levelIndex;
  const GameStart(this.levelIndex);

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
