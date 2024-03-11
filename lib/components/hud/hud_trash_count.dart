
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart' as material;
import '../../bloc/game_stats/game_stats_barrel.dart';
import '../../constants.dart';
import '../../levels/level_parameters.dart';
import '../../core/game_scene.dart';

class HudTrashCount extends PositionComponent with HasGameRef<GameScene>
{
  TrashType trashType;
  int totalTrash;
  HudTrashCount({required this.trashType,required this.totalTrash, super.position});

  int _anyTrashCount = 0;

  final TextPaint _countPaint = TextPaint(
    style: const material.TextStyle(
      fontWeight: material.FontWeight.bold,
        color: material.Colors.blue, fontSize: 20),
  );

  late SpriteComponent _trashIcon;
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
    _trashIcon = SpriteComponent(
        sprite: sprite,
        anchor: Anchor.center
    );

    await add(_trashIcon);

    _txtCount = TextComponent(
      text: '0/$totalTrash',
      position: Vector2(_trashIcon.position.x + 40,_trashIcon.y),
      textRenderer: _countPaint ,
      anchor: Anchor.center,
    );
    await add(_txtCount);

    scale = Vector2.all(0.7);
  }

  Future<void> _initBlocListener() async {
    await add(
      FlameBlocListener<GameStatsBloc, GameStatsState>(
        listenWhen: (previousState, newState) {
          return true;
        },
        onNewState: (state) {
           if(state.trashType != null)
              _updateCountWithState(state);
        },
      ),
    );
  }

  void setTrash(TrashType type,int total)
  {
    trashType = type;
    totalTrash = total;

    String trashPath = (trashType == TrashType.any) ? pathFishNet : trashPathMap[trashType]!;
    var sprite = Sprite(gameRef.images.fromCache(trashPath));
    _trashIcon.sprite = sprite;
  }

  void resetCount()
  {
    _anyTrashCount = 0;
     _txtCount.text = '0/$totalTrash';
  }

  void _updateCountWithState(GameStatsState state)
  {
    if(trashType == TrashType.any)
    {
      _anyTrashCount++;
      _txtCount.text = "$_anyTrashCount/$totalTrash";
    }
    else if(state.trashType == trashType){
      _txtCount.text = "${state.trashCount}/$totalTrash";
    }
  }

}