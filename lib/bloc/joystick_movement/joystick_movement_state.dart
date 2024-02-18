
import 'package:equatable/equatable.dart';
import 'package:flame/components.dart';


class JoystickMovementState extends Equatable {
  final Vector2 velocityDirection;
  final double angle;

   const JoystickMovementState({
    required this.velocityDirection, this.angle = 0,
  });

  JoystickMovementState.empty() : this(velocityDirection: Vector2.zero(),angle: 0);

  JoystickMovementState copyWith({
    Vector2? velocityDirection,
    double? angle,
  }) {
    return JoystickMovementState(velocityDirection: velocityDirection ?? this.velocityDirection,angle: angle ?? this.angle);
  }

  @override
  List<Object?> get props => [velocityDirection,angle];
}

