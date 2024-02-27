
import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import '../../mixins/update_mixin.dart';
import '../../utils/utils.dart';

class HudTimer extends PositionComponent with UpdateMixin
{
  Vector2? pos;
  double timeLimit;
  Function(double)? remainingTime;
  VoidCallback? timerFinished;
  HudTimer({required this.timeLimit,this.pos,this.remainingTime,this.timerFinished}){
    pos = pos ?? Vector2.zero();
  }

  final TextPaint _textPaint = TextPaint(
    style: const material.TextStyle(color: material.Colors.black, fontSize: 20),
  );

  late Timer _countdown;
  double _remainingTime = 0;

  @override
  FutureOr<void> onLoad() async{
    _countdown = Timer(timeLimit);
    position = pos!;
    return super.onLoad();
  }

  @override
  void runUpdate(double dt) {
    _countdown.update(dt);
    if(_countdown.isRunning()) {
      _remainingTime = timeLimit - _countdown.current;
      remainingTime?.call(_remainingTime);
    }
    else if(_countdown.finished)
    {
      timerFinished?.call();
      _countdown.stop();
    }
  }

  @override
  void render(Canvas canvas) {
    _textPaint.render(
      canvas,
      _runningTime,
      Vector2.zero(),
    );
    super.render(canvas);
  }

  String get _runningTime
  {
    return (_countdown.isRunning()) ? Utils.formatTime(_remainingTime) : "00:00";
  }

}