

import 'package:flame/components.dart';
import 'package:ocean_cleanup/mixins/update_mixin.dart';
import '../../../custom_paint/radial_progress_painter.dart';

class RadialProgress extends CustomPainterComponent with UpdateMixin {
  final double strokeWidth;
  final double maxDuration;
  RadialProgress({
    required this.maxDuration,
    required this.strokeWidth,
    super.size,
    super.position});
  double value = 0;

  late RadialProgressPainter? _radialPainter;

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
  }

  @override
  void onRemove() {
    _radialPainter = null;
    super.onRemove();
  }
}