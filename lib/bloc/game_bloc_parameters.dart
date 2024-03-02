


import 'game/game_bloc.dart';
import 'game_stats/game_stats_bloc.dart';

class GameBlocParameters {
  final GameBloc gameBloc;
  final GameStatsBloc gameStatsBloc;

  const GameBlocParameters ({
    required this.gameBloc,
    required this.gameStatsBloc,
  });

}