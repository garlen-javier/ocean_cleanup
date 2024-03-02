import 'dart:math';
import 'package:flutter/material.dart';

class RadialProgressPainter extends CustomPainter {
 // final List<Color> backgroundGradientColors;
  final double minValue;
  final double maxValue;
  final double strokeWidth;

  RadialProgressPainter({
   // required this.backgroundGradientColors,
    required this.minValue,
    required this.maxValue,
    required this.strokeWidth,
  });

  double value = 0;

  @override
  void paint(Canvas canvas, Size size) {

    final double diameter = min(size.height, size.width);
    final double radius = diameter / 2;
    final double centerX = radius;
    final double centerY = radius;

    // Calculate the start and sweep angles to draw the progress arc.
    double startAngle = -pi / 2;
    double sweepAngle = 2 * pi * value / maxValue;
    double degree = sweepAngle * 360/(2 * pi);

    final Paint progressPaint = Paint()
     ..color = _getColorForDegree(degree)
      // ..shader = SweepGradient(
      //   colors: backgroundGradientColors,
      //   startAngle: -pi / 2,
      //   endAngle: 3 * pi / 2,
      //   tileMode: TileMode.repeated,
      // ).createShader(Rect.fromCircle(center: Offset(centerX, centerY), radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Paint for the progress track.
    final Paint progressTrackPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final Paint fillPaint = Paint()
      ..color = const Color(0xFFffe6b9)
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw the filled circle
    Offset center = Offset(centerX, centerY);
    canvas.drawCircle(center, radius - (strokeWidth-4), fillPaint);
    // Drawing track.
    canvas.drawCircle(center, radius, progressTrackPaint);
    // Drawing border.
    canvas.drawCircle(center, radius + (strokeWidth-4), borderPaint);

    // Drawing progress.
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }
  
  Color _getColorForDegree(double degree) {
    if (degree >= 0 && degree < 90) {
      return Colors.green; 
    } else if (degree >= 90 && degree < 180) {
      return Colors.yellow; 
    } else if (degree >= 180 && degree < 270) {
      return Colors.orange; 
    } else {
      return Colors.red; 
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}