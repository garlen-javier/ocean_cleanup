
import 'package:equatable/equatable.dart';
import 'package:flame/components.dart';


class PlayerMovementState extends Equatable {
  final Vector2 velocityDirection;

   const PlayerMovementState({
    required this.velocityDirection,
  });

  PlayerMovementState.empty() : this(velocityDirection: Vector2.zero());

  PlayerMovementState copyWith({
    Vector2? velocityDirection,
  }) {
    return PlayerMovementState(velocityDirection: velocityDirection ?? this.velocityDirection);
  }

  @override
  List<Object?> get props => [velocityDirection];
}

