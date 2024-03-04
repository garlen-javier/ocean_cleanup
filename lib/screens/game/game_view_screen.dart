
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/game/game_bloc.dart';
import '../../bloc/game_bloc_parameters.dart';
import '../../bloc/game_stats/game_stats_bloc.dart';
import '../../scenes/game_scene.dart';

class GameView extends StatelessWidget {
  final int levelIndex;
  const GameView({required this.levelIndex,super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      focusNode: FocusNode(),
      game: GameScene(
          levelIndex: levelIndex,
          blocParameters: GameBlocParameters(
            gameBloc: context.read<GameBloc>(),
            gameStatsBloc:  context.read<GameStatsBloc>(),
          )
      ),
    );
  }
}