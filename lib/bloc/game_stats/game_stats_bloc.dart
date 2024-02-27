


import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';
import '../../levels/level_parameters.dart';
import 'game_stats_state.dart';

class GameStatsBloc extends Cubit<GameStatsState> {
  GameStatsBloc() : super(const GameStatsState.empty()){
    _trashCountMap.putIfAbsent(TrashType.any, () => 0);
  }

  final Map<TrashType,int> _trashCountMap = {};
  int health = defaultHealth;

  //#region Trash Count

   void addTrash(TrashType type){
     if(_trashCountMap.containsKey(type))
     {
       int lastCount = _trashCountMap[type]!;
       lastCount++;
       _trashCountMap[type] = lastCount;

       emit(state.copyWith(trashType: type,trashCount: lastCount));
     }
     else{
       _trashCountMap.putIfAbsent(type, () => 1);
       emit(state.copyWith(trashType: type,trashCount: 1));
     }
   }

  void removeTrash(TrashType type,int penalty){
    if(_trashCountMap.containsKey(type))
    {
      int lastCount = _trashCountMap[type]!;
      lastCount-=penalty;
      _trashCountMap[type] = lastCount;

      emit(state.copyWith(trashType: type,trashCount: lastCount));
    }
  }

   void resetTrashCount()
   {
     _trashCountMap.forEach((type, count) {
       emit(state.copyWith(trashType: type,trashCount: 0));
     });
     _trashCountMap.clear();
     _trashCountMap.putIfAbsent(TrashType.any, () => 0);
   }

   int totalTrashCount()
   {
     int total = 0;
     _trashCountMap.forEach((type, count) {
        total+=count;
     });
     return total;
   }

  int trashCountByType(TrashType type) => _trashCountMap[type] ?? 0;
   //#endregion

  //#region Health
  void addHealth(int hp){
    health+=hp;
    emit(state.copyWith(health: health));
  }

  void minusHealth(int damage){
    health-=damage;
    emit(state.copyWith(health: health));
  }

  void resetHealth()
  {
    health = defaultHealth;
    emit(state.copyWith(health:defaultHealth));
  }
  //#endregion

  //#region Condition
  void timerFinish()
  {
    emit(state.copyWith(timerFinish: true));
  }

  void rescueFailed()
  {
    emit(state.copyWith(rescueFailed: true));
  }
  //#endregion
}

