

import 'joystick_movement/joystick_movement_bloc.dart';
import 'player_stats/player_stats_bloc.dart';

class GameBlocParameters {
  final JoystickMovementBloc joystickMovementBloc;
  final PlayerStatsBloc playerStatsBloc;

  const GameBlocParameters ({
    required this.joystickMovementBloc,
    required this.playerStatsBloc,
  });

}