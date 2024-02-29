import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_barrel.dart';


class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState.empty()) {

    on<GameReady>(
          (event, emit)  {
            emit(state.copyWith(phase: GamePhase.ready));
      },
    );

    on<GameStart>(
          (event, emit)  {
            emit(state.copyWith(levelIndex: event.levelIndex, phase: GamePhase.playing));
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
          (event, emit) {
            GamePhase gamePhase = (event is GameWin) ? GamePhase.win : GamePhase.gameOver;
            emit(state.copyWith(result: event.result,phase: gamePhase));
      },
    );

    on<GameQuit>(
          (event, emit) => emit(const GameState.empty(),
      ),
    );

    on<Default>(
          (event, emit) {
            emit(const GameState.empty());
          }
    );
  }


}
