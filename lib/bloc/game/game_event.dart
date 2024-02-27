
import 'package:equatable/equatable.dart';
import 'package:ocean_cleanup/game_result.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class GameStart extends GameEvent {

  final Future Function(int) tryLoadLevel;
  final int levelIndex;
  const GameStart(this.tryLoadLevel,this.levelIndex);

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

