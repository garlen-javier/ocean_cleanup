

import 'package:flame/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'player_movement_state.dart';


class PlayerMovementBloc extends Cubit<PlayerMovementState> {
  PlayerMovementBloc() : super(PlayerMovementState.empty());

  void move(Vector2 direction) {
    emit(state.copyWith(velocityDirection: direction));
  }
}

