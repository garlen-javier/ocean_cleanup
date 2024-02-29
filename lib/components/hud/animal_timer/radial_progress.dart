

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:ocean_cleanup/mixins/update_mixin.dart';
import '../../../custom_paint/radial_progress_painter.dart';

class RadialProgress extends CustomPainterComponent with UpdateMixin {
  final double strokeWidth;
  final double maxDuration;
  final VoidCallback? onFinish;
  RadialProgress({
    required this.maxDuration,
    required this.strokeWidth,
    this.onFinish,
    super.size,
    super.position});
  double value = 0;

  late RadialProgressPainter? _radialPainter;
  bool isComplete = false;

  @override
  Future<void> onLoad() async {
    _radialPainter = RadialProgressPainter(
      minValue: 0,
      maxValue: maxDuration,
      strokeWidth: strokeWidth,
    );
    painter = _radialPainter;
    anchor = Anchor.center;
  }

  @override
  void runUpdate(double dt) {
    if(value < maxDuration) {
      value+=dt;
      _radialPainter?.value = value;
    }
    else if(!isComplete) {
      isComplete = true;
      onFinish?.call();
    }
  }

  @override
  void onRemove() {
    _radialPainter = null;
    super.onRemove();
  }
}