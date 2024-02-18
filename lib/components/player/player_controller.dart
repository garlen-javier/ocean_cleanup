

import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/services.dart';
import '../../bloc/joystick_movement/joystick_movement_barrel.dart';
import 'player.dart';

///Player inputs should be handled here
class PlayerController extends Component with KeyboardHandler
{
  final Player player;
  PlayerController({required this.player});

  Vector2 _keyboardVelo = Vector2.zero();

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
          _handleJoystickMovement(state.velocityDirection,state.angle);
        },
      ),
    );
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    final bool handled;
    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      _keyboardVelo.x = isKeyDown ? -1 : 0;
      handled = true;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      _keyboardVelo.x = isKeyDown ? 1 : 0;
      handled = true;
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      _keyboardVelo.y = isKeyDown ? -1 : 0;
      handled = true;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      _keyboardVelo.y = isKeyDown ? 1 : 0;
      handled = true;
    } else {
      _keyboardVelo = Vector2.zero();
      handled = false;
    }

    if (handled) {
      double angle = _keyboardVelo.screenAngle();
      _handleKeyboardMovement(_keyboardVelo, angle);
      return false;
    } else {
      return super.onKeyEvent(event, keysPressed);
    }
  }

  void _handleJoystickMovement(Vector2 velocityDirection,double angle)
  {
     player.updateDirection(velocityDirection,angle);
  }

  void _handleKeyboardMovement(Vector2 velocityDirection,double angle)
  {
     player.updateDirection(velocityDirection,angle);
  }

}