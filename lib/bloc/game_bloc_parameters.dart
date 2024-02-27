

import 'game/game_bloc.dart';
import 'game_stats/game_stats_bloc.dart';
import 'joystick_movement/joystick_movement_bloc.dart';

class GameBlocParameters {
  final GameBloc gameBloc;
  final JoystickMovementBloc joystickMovementBloc;
  final GameStatsBloc gameStatsBloc;

  const GameBlocParameters ({
    required this.gameBloc,
    required this.joystickMovementBloc,
    required this.gameStatsBloc,
  });

}