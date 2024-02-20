
import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart' as material;
import '../../bloc/player_stats/player_stats_barrel.dart';

class HudStats extends PositionComponent
{
  final TextPaint _scorePaint = TextPaint(
    style: const material.TextStyle(color: material.Colors.black, fontSize: 20),
  );

  final TextPaint _healthPaint = TextPaint(
    style: const material.TextStyle(color: material.Colors.black, fontSize: 20),
  );

  @override
  FutureOr<void> onLoad() async{
    _initBlocListener();
    return super.onLoad();
  }

  Future<void> _initBlocListener() async {
    await add(
      FlameBlocListener<PlayerStatsBloc, PlayerStatsState>(
        listenWhen: (previousState, newState) {
          bool isScoreChange = previousState.score != newState.score;
          bool isHealthChange = previousState.health != newState.health;
          return isScoreChange || isHealthChange;
        },
        onNewState: (state) {
         // print(state.score);
        },
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    _scorePaint.render(
      canvas,
      "test",
      Vector2.zero(),
    );
    super.render(canvas);
  }


}