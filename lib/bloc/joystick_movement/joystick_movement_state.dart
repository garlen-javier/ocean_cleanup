
import 'package:equatable/equatable.dart';
import 'package:flame/components.dart';


class JoystickMovementState extends Equatable {
  final Vector2 velocityDirection;

   const JoystickMovementState({
    required this.velocityDirection,
  });

  JoystickMovementState.empty() : this(velocityDirection: Vector2.zero());

  JoystickMovementState copyWith({
    Vector2? velocityDirection,
  }) {
    return JoystickMovementState(velocityDirection: velocityDirection ?? this.velocityDirection);
  }

  @override
  List<Object?> get props => [velocityDirection];
}

