
import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ocean_cleanup/constants.dart';
import 'package:ocean_cleanup/utils/math_utils.dart';

import '../../mixins/update_mixin.dart';
import '../../core/game_scene.dart';

class HudOctopusMeter extends PositionComponent with UpdateMixin, HasGameRef<GameScene>
{
  final int stageIndex;
  final int totalStageNum;
  double timeLimit;

  HudOctopusMeter({
    required this.stageIndex,
    required this.totalStageNum,
    required this.timeLimit,
    super.position});

  late SpriteComponent _meterBar;
  late ClipComponent _meterbarClip;

  double _percentPerStage = 0.2; // can be 1.0 / no. of stage
  double _countdown = 0;
  double _barPercent = 1.0;
  double _decreasePerSecond = 0;
  double _barHeight = 0;

  @override
  FutureOr<void> onLoad() async {
 
    var spMeterHolder = Sprite(gameRef.images.fromCache(pathMeterHolder));
    SpriteComponent meterHolder = SpriteComponent(
        sprite: spMeterHolder,
    );

    var spMeterBar = Sprite(gameRef.images.fromCache(pathMeterBar));
    _meterBar = SpriteComponent(
        sprite: spMeterBar,
    );

    _meterBar.paint.colorFilter = const ColorFilter.mode(Colors.red, BlendMode.modulate);
    _meterbarClip = ClipComponent.rectangle (
      size: _meterBar.size,
      children: [_meterBar], // Add your SpriteComponent as a child
    );
    _meterbarClip.anchor = Anchor.topRight;
    _meterbarClip.position.y = _meterBar.size.y;
    _meterbarClip.angle = MathUtils.degToRad(180);

    _barHeight = _meterbarClip.size.y;
    _percentPerStage = 1.0/totalStageNum;
    _decreasePerSecond = _percentPerStage / timeLimit ;

    updateLimitWithStage(stageIndex, timeLimit);
    await add(meterHolder);
    await meterHolder.add(_meterbarClip);
    return super.onLoad();
  }

  @override
  void runUpdate(double dt) {
    //Probably no need to reduce percent per second
    // if (_countdown < timeLimit) {
    //   _countdown+=dt;
    //   _barPercent-= _decreasePerSecond * dt;
    //   changeBarPercent(_barPercent);
    // }
  }

  void updateLimitWithStage(int stageIndex,double limit)
  {
    _updateBarPercentWithStage(stageIndex);
    _countdown = 0;
    timeLimit = limit;
  }

  void _updateBarPercentWithStage(int stageIndex)
  {
    _barPercent = 1.0 - _percentPerStage * stageIndex;
    changeBarPercent(_barPercent);
  }

  void changeBarPercent(double value)
  {
    _meterbarClip.size.y = _barHeight * value;
    _changeBarColor(_getColorForPercent(value));
  }

  void _changeBarColor(Color color)
  {
    _meterBar.paint.colorFilter = ColorFilter.mode(color, BlendMode.modulate);
  }

  Color _getColorForPercent(double percent) {
    if (percent > 0.6 && percent <= 1.0) {
      return Colors.red;
    } else if (percent > 0.2 && percent <= 0.6) {
      return const Color(0xFFFDA801);
    } else {
      return const Color(0xFF2ACF00);
    }
  }

}