
import 'dart:async';
import 'package:flame/components.dart';
import 'package:ocean_cleanup/components/hud/hud_trash_count.dart';
import '../../levels/level_parameters.dart';
import '../../scenes/game_scene.dart';

class HudStats extends PositionComponent with HasGameRef<GameScene>
{
  Set<TrashType> trashTypes = {};
  HudStats({required this.trashTypes});

  late Vector2 _gameSize;

  @override
  FutureOr<void> onLoad() async{
    _gameSize = gameRef!.size;

    await loadTrashCounter(60);
    return super.onLoad();
  }

  Future<void> loadTrashCounter(int marginX) async {
    int count = trashTypes.length;

    Vector2 counterPos = Vector2(-_gameSize.x * 0.12 * (count-1)/count,-_gameSize.y * 0.35);
    for(int i = 0; i < count ; ++i)
    {
      var trashCounter = HudTrashCount(trashType: trashTypes.elementAt(i), position: counterPos);
      await add(trashCounter);
      counterPos = Vector2(trashCounter.x + marginX,trashCounter.y);
    }
  }

  @override
  void onGameResize(Vector2 size) {
    _gameSize = size;
    super.onGameResize(size);
  }

}