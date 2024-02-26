
import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;

class HudTimer extends PositionComponent
{
  Vector2? pos;
  double timeLimit;
  VoidCallback? timerFinished;
  HudTimer({required this.timeLimit,this.pos,this.timerFinished}){
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
    if(_countdown.finished)
    {
      timerFinished?.call();
      _countdown.stop();
    }
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    _textPaint.render(
      canvas,
      _getRunningTime,
      Vector2.zero(),
    );
    super.render(canvas);
  }

  String get _getRunningTime
  {
    String formattedTime = "";
    if(_countdown.isRunning())
      formattedTime = _formatTime((timeLimit+1) - _countdown.current);
    else
      formattedTime = "00:00";
    return formattedTime;
  }

  String _formatTime(double time) {
    final minutes = (time / 60).floor();
    final seconds = (time % 60).floor();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}