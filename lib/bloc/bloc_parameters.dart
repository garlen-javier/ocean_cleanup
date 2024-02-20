

import 'joystick_movement/joystick_movement_bloc.dart';
import 'player_stats/player_stats_bloc.dart';

class BlocParameters {
  final JoystickMovementBloc joystickMovementBloc;
  final PlayerStatsBloc playerStatsBloc;

  const BlocParameters ({
    required this.joystickMovementBloc,
    required this.playerStatsBloc,
  });

}