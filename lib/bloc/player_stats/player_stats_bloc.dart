


import 'package:flutter_bloc/flutter_bloc.dart';
import 'player_stats_state.dart';


class PlayerStatsBloc extends Cubit<PlayerStatsState> {
  PlayerStatsBloc() : super(const PlayerStatsState.empty());

   static const int _maxHealth = 3;
   int _score = 0;
   int _health = _maxHealth;

  //#region Score
   void addScore(int points){
     _score+=points;
     emit(state.copyWith(score: _score));
   }

  void minusScore(int penalty){
    _score-=penalty;
    emit(state.copyWith(health: _score));
  }

   void resetScore()
   {
    emit(state.copyWith(score:0));
   }
   //#endregion

  //#region Health
  void addHealth(int hp){
    _health+=hp;
    emit(state.copyWith(health: _health));
  }

  void minusHealth(int damage){
    _health-=damage;
    emit(state.copyWith(health: _health));
  }

  void resetHealth()
  {
    emit(state.copyWith(score:_maxHealth));
  }
  //#endregion
}

