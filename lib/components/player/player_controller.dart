

import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import '../../bloc/joystick_movement/joystick_movement_barrel.dart';
import 'player.dart';

///Player inputs should be handled here
class PlayerController extends Component
{
  final Player player;
  PlayerController({required this.player});

   @override
  FutureOr<void> onLoad() async {
    await _initBlocListener();
    return super.onLoad();
  }

  Future<void> _initBlocListener() async {
    await add(
      FlameBlocListener<JoystickMovementBloc, JoystickMovementState>(
        listenWhen: (previousState, newState) {
          return previousState.velocityDirection != newState.velocityDirection;
        },
        onNewState: (state) {
          _updateJoystickDirection(state.velocityDirection);
        },
      ),
    );
  }

  void _updateJoystickDirection(Vector2 velocityDirection)
  {
    player.updateDirection(velocityDirection);
  }

}