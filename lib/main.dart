import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocean_cleanup/constants.dart';
import '../../bloc/joystick_movement/joystick_movement_barrel.dart';
import 'bloc/game/game_bloc.dart';
import 'bloc/game_bloc_parameters.dart';
import 'bloc/game_stats/game_stats_bloc.dart';
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
        BlocProvider<JoystickMovementBloc>(create: (_) => JoystickMovementBloc()),
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
      game: GameScene(
        blocParameters: GameBlocParameters(
            gameBloc: context.read<GameBloc>(),
            joystickMovementBloc: context.read<JoystickMovementBloc>(),
            gameStatsBloc:  context.read<GameStatsBloc>(),
        )
      ),
    );
  }
}