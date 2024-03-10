import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocean_cleanup/bloc/game/game_barrel.dart';
import 'package:ocean_cleanup/components/popups/gameover_popup.dart';
import 'package:ocean_cleanup/components/popups/pause_popup.dart';
import 'package:ocean_cleanup/components/popups/victory_popup.dart';
import 'package:ocean_cleanup/screens/levels/levels_screen.dart';
import '../../bloc/game_bloc_parameters.dart';
import '../../bloc/game_stats/game_stats_barrel.dart';
import '../../scenes/game_scene.dart';

class GameViewScreen extends StatefulWidget {
  final int levelIndex;
  const GameViewScreen({required this.levelIndex, super.key});

  @override
  State<GameViewScreen> createState() => _GameViewScreenState();
}

class _GameViewScreenState extends State<GameViewScreen> {
  late GameBloc _gameBloc;
  late GameStatsBloc _gameStatsBloc;

  @override
  void initState() {
    _gameBloc = BlocProvider.of<GameBloc>(context);
    _gameStatsBloc = BlocProvider.of<GameStatsBloc>(context);
    super.initState();
  }

  BlocListener<GameBloc, GameState> _gameListener() {
    return BlocListener<GameBloc, GameState>(
      bloc: _gameBloc,
      listenWhen: (previousState, newState) {
        return previousState != newState;
      },
      listener: (BuildContext context, GameState state) {
        debugPrint("GameViewScreen GameBloc : $state");
        switch (state.phase) {
          case GamePhase.start:
            break;
          case GamePhase.playing:
            break;
          case GamePhase.pause:
            //Just sample usage to call event : _gameBloc.add(const GameResume());
            showPausePopup(context, _gameBloc , widget.levelIndex);

            break;
          case GamePhase.win:
            debugPrint("GameViewScreen Win! " + state!.result.toString());
            showVictoryPopup(context, widget.levelIndex, state.result!.score);

            break;
          case GamePhase.gameOver:
            debugPrint("GameViewScreen GameOver!" + state!.result.toString());
            showGameOverPopup(context, widget.levelIndex, state.result!.score);
            break;

          default:
            break;
        }
      },
    );
  }

  BlocListener<GameStatsBloc, GameStatsState> _gameStatListener() {
    return BlocListener<GameStatsBloc, GameStatsState>(
      bloc: _gameStatsBloc,
      listenWhen: (previousState, newState) {
        return previousState.freedAnimal != newState.freedAnimal;
      },
      listener: (BuildContext context, GameStatsState state) {
        if (state.freedAnimal != null && !state.rescueFailed) {
          _gameBloc.add(const GameSuspend());
          debugPrint("GameViewScreen freedAnimal: ${state.freedAnimal}");
          //TODO: an Animal is free
          //call _gameBloc.add(const GameResume()); to unsuspend
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        _gameListener(),
        _gameStatListener(),
      ],
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop) {
            //TODO: add your Pause or Exit popup here.
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LevelsScreen()));
          }
        },
        child: GameWidget(
          focusNode: FocusNode(),
          game: GameScene(
              levelIndex: widget.levelIndex,
              blocParameters: GameBlocParameters(
                gameBloc: context.read<GameBloc>(),
                gameStatsBloc: context.read<GameStatsBloc>(),
              )),
        ),
      ),
    );
  }
}
