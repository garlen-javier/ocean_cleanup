

import 'game/game_bloc.dart';
import 'joystick_movement/joystick_movement_bloc.dart';
import 'player_stats/player_stats_bloc.dart';

class GameBlocParameters {
  final GameBloc gameBloc;
  final JoystickMovementBloc joystickMovementBloc;
  final PlayerStatsBloc playerStatsBloc;

  const GameBlocParameters ({
    required this.gameBloc,
    required this.joystickMovementBloc,
    required this.playerStatsBloc,
  });

}