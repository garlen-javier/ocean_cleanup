import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';
import 'game_barrel.dart';


class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState.empty()) {

    on<GameStart>(
          (event, emit)  {
            emit(const GameState.empty());
            emit(state.copyWith(levelIndex: event.levelIndex, stageIndex: event.stageIndex, phase: GamePhase.start));
      },
    );

    on<GameRestart>(
          (event, emit)  {
            int currentLevel = state.levelIndex;
            emit(const GameState.empty());
            emit(state.copyWith(levelIndex: currentLevel, phase: GamePhase.start));
      },
    );

    on<GameStartNext>(
          (event, emit)  {
            int currentLevel = state.levelIndex;
            if(currentLevel < maxStageLevel-1) {
              currentLevel++;
              emit(const GameState.empty());
              emit(state.copyWith(levelIndex: currentLevel, phase: GamePhase.start));
            }
      },
    );


    on<GamePlaying>(
          (event, emit)  {
        emit(state.copyWith(phase: GamePhase.playing));
      },
    );

    on<GameSuspend>(
          (event, emit) {
        if(state.phase == GamePhase.playing)
          emit(state.copyWith(phase:GamePhase.suspended));
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
            if(state.phase == GamePhase.pause || state.phase == GamePhase.suspended)
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
          (event, emit) => emit(state.copyWith(phase:GamePhase.quit))
    );

    on<Default>(
          (event, emit) {
            emit(const GameState.empty());
          }
    );
  }


}
