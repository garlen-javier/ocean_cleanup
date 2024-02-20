
import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart' as material;

class GameTimer extends PositionComponent
{
  Vector2? pos;
  double timeLimit;
  GameTimer({required this.timeLimit,this.pos}){
    pos = pos ?? Vector2.zero();
  }

  final TextPaint _textPaint = TextPaint(
    style: const material.TextStyle(color: material.Colors.black, fontSize: 20),
  );
  late Timer _countdown;

  @override
  FutureOr<void> onLoad() async{
    _countdown = Timer(timeLimit);
    position = pos!;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _countdown.update(dt);
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    final formattedTime = _formatTime((timeLimit+1) - _countdown.current);
    _textPaint.render(
      canvas,
      formattedTime,
      Vector2.zero(),
    );
    super.render(canvas);
  }

  String _formatTime(double time) {
    final minutes = (time / 60).floor();
    final seconds = (time % 60).floor();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}