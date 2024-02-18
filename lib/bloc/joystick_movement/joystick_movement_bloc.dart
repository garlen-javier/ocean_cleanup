

import 'package:flame/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'joystick_movement_state.dart';


class JoystickMovementBloc extends Cubit<JoystickMovementState> {
  JoystickMovementBloc() : super(JoystickMovementState.empty());

  void move(Vector2 direction,double angle) {
    emit(state.copyWith(velocityDirection: direction,angle: angle));
  }
}

