
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart' as material;
import '../../bloc/game/game_bloc.dart';
import '../../bloc/game/game_state.dart';
import '../../bloc/player_stats/player_stats_barrel.dart';
import '../../constants.dart';
import '../../levels/level_parameters.dart';
import '../../scenes/game_scene.dart';

class HudTrashCount extends PositionComponent with HasGameRef<GameScene>
{
  final TrashType trashType;
  HudTrashCount({required this.trashType,super.position});

  int _anyTrashCount = 0;

  final TextPaint _countPaint = TextPaint(
    style: const material.TextStyle(
      fontWeight: material.FontWeight.bold,
        color: material.Colors.blue, fontSize: 20),
  );

  late TextComponent _txtCount;

  @override
  FutureOr<void> onLoad() async {
    await _loadDisplay();
    await _initBlocListener();
    return super.onLoad();
  }

  Future<void> _loadDisplay() async {
    String trashPath = (trashType == TrashType.any) ? pathFishNet : trashPathMap[trashType]!;
    var sprite = Sprite(gameRef.images.fromCache(trashPath));
    SpriteComponent trashSymbol = SpriteComponent(
        sprite: sprite,
        anchor: Anchor.center
    );

    await add(trashSymbol);

    _txtCount = TextComponent(
      text: '0',
      position: Vector2(trashSymbol.position.x + 35,trashSymbol.y),
      textRenderer: _countPaint ,
      anchor: Anchor.center,
    );
    await add(_txtCount);

    scale = Vector2.all(0.7);
  }

  Future<void> _initBlocListener() async {
    await add(
      FlameBlocListener<PlayerStatsBloc, PlayerStatsState>(
        listenWhen: (previousState, newState) {
          return true;
        },
        onNewState: (state) {
           _updateCountWithState(state);
        },
      ),
    );
  }

  void _updateCountWithState(PlayerStatsState state)
  {
    if(trashType == TrashType.any)
    {
      _anyTrashCount++;
      _txtCount.text = _anyTrashCount.toString();
    }
    else if(trashType == state.trashType){
      _txtCount.text = state.trashCount.toString();
    }
  }
}