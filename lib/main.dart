import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocean_cleanup/screens/intro%20game/intro_game_screen.dart';
import 'package:ocean_cleanup/utils/config_size.dart';
import '../../bloc/joystick_movement/joystick_movement_barrel.dart';
import 'bloc/bloc_parameters.dart';
import 'bloc/player_stats/player_stats_barrel.dart';
import 'scenes/game_scene.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(const GamePage());
}

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<JoystickMovementBloc>(
            create: (_) => JoystickMovementBloc()),
        BlocProvider<PlayerStatsBloc>(create: (_) => PlayerStatsBloc()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroGameScreen(),
      ),
    );
  }
}

// class GameView extends StatelessWidget {
//   const GameView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GameWidget(
//       game: GameScene(
//         blocParameters: BlocParameters(
//             joystickMovementBloc: context.read<JoystickMovementBloc>(),
//             playerStatsBloc:  context.read<PlayerStatsBloc>(),
//         )
//       ),
//     );
//   }
// }