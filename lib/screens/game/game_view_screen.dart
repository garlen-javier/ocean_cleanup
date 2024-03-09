
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocean_cleanup/bloc/game/game_barrel.dart';
import '../../bloc/game/game_bloc.dart';
import '../../bloc/game/game_state.dart';
import '../../bloc/game_bloc_parameters.dart';
import '../../bloc/game_stats/game_stats_bloc.dart';
import '../../scenes/game_scene.dart';

class GameViewScreen extends StatefulWidget {
  final int levelIndex;
  const GameViewScreen({required this.levelIndex,super.key});

  @override
  State<GameViewScreen> createState() => _GameViewScreenState();
}

class _GameViewScreenState extends State<GameViewScreen> {

  late GameBloc _gameBloc;

  @override
  void initState() {
    _gameBloc = BlocProvider.of<GameBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _gameBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc,GameState>(
      bloc: _gameBloc,
      listenWhen: (previousState, newState) {
        return previousState != newState;
      },
      listener: (BuildContext context, GameState state) {
        debugPrint("GameViewScreen GameBloc : $state");
        switch(state.phase)
        {
          case GamePhase.start:

            break;
          case GamePhase.playing:

            break;
          case GamePhase.pause:
            //Just sample usage to call event : _gameBloc.add(const GameResume());

            break;
          case GamePhase.win:
            debugPrint("GameViewScreen Win! " + state!.result.toString() );
            break;
          case GamePhase.gameOver:

            debugPrint("GameViewScreen GameOver!" + state!.result.toString() );
            break;
          default:
            break;
        }
      },
      child: GameWidget(
        focusNode: FocusNode(),
        game: GameScene(
            levelIndex: widget.levelIndex,
            blocParameters: GameBlocParameters(
              gameBloc: context.read<GameBloc>(),
              gameStatsBloc:  context.read<GameStatsBloc>(),
            )
        ),
      ),
    );
  }
}