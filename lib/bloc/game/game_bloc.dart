import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_barrel.dart';


class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState.empty()) {

    on<GameStart>(
          (event, emit) async {
            await event.tryLoadLevel.call(event.levelIndex);
            emit(state.copyWith(phase: GamePhase.playing));
      },
    );

    on<GamePause>(
          (event, emit) {
            if(state.phase == GamePhase.playing)
              emit(state.copyWith(phase:GamePhase.pause));
      },
    );

    on<GameResume>(
          (event, emit) {
            if(state.phase == GamePhase.pause)
              emit(state.copyWith(phase: GamePhase.playing));
      },
    );

    on<GameFinish>(
          (event, emit) { //TODO: emit result
            GamePhase gamePhase = (event is GameWin) ? GamePhase.win : GamePhase.gameOver;
            emit(state.copyWith(levelIndex: event.levelIndex,phase: gamePhase));
      },
    );

    on<GameQuit>(
          (event, emit) => emit(const GameState.empty(),
      ),
    );


  }


}
