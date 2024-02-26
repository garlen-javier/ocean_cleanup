
import 'package:flame/components.dart';

mixin UpdateMixin on PositionComponent {
  void runUpdate(double dt);
}

mixin HasUpdateMixin on World {
  void runUpdate(double dt);
}