
import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import '../../mixins/update_mixin.dart';
import '../../utils/utils.dart';

class HudTimer extends PositionComponent with UpdateMixin
{
  double initialLimit;
  Function(double,double)? remainingTime;
  VoidCallback? timerFinished;
  HudTimer({required this.initialLimit,this.remainingTime,this.timerFinished,super.position});

  final TextPaint _textPaint = TextPaint(
    style: const material.TextStyle(color: material.Colors.black, fontSize: 20),
  );

  late Timer _countdown;
  double _remainingTime = 0;

  @override
  FutureOr<void> onLoad() async{
    _countdown = Timer(initialLimit);
    return super.onLoad();
  }

  void setTimeLimit(double limit) =>  _countdown.limit = limit;
  void start() => _countdown.start();

  @override
  void runUpdate(double dt) {
    _countdown.update(dt);
    if(_countdown.isRunning()) {
      _remainingTime = _countdown.limit - _countdown.current;
      remainingTime?.call(_remainingTime,_countdown.current);
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