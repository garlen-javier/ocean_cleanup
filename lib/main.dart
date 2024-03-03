import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/game/game_bloc.dart';
import 'bloc/game_bloc_parameters.dart';
import 'bloc/game_stats/game_stats_bloc.dart';
import 'constants.dart';
import 'level_tester.dart';
import 'scenes/game_scene.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  if(!isTesterMode)
   runApp( const GamePage());
  else
    runApp(const LevelTester());
}

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(create: (_) => GameBloc()),
        BlocProvider<GameStatsBloc>(create: (_) => GameStatsBloc()),
      ],
      child: const GameView(),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      focusNode: FocusNode(),
      game: GameScene(
        blocParameters: GameBlocParameters(
            gameBloc: context.read<GameBloc>(),
            gameStatsBloc:  context.read<GameStatsBloc>(),
        )
      ),
    );
  }
}