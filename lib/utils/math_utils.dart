
import 'dart:math';
import 'package:flame/components.dart';

class MathUtils{

  static double dirToAngleRad(Vector2 dir) {
    return atan2(dir.y, dir.x);
  }

  static Vector2 angleRadToDir(double rad) {
    return Vector2(cos(rad), sin(rad));
  }

  static double radToDeg (double rad) {
    return rad * 360/tau;
  }

  static double degToRad (double degree) {
    return degree * tau/360;
  }

  static double tau = pi * 2;
}