

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'player.dart';

///Player inputs should be handled here
class PlayerController extends Component with KeyboardHandler
{
  final Player player;
  PlayerController({required this.player});

  Vector2 _keyboardVelo = Vector2.zero();
  double _keyboardAngle = 0;
  bool _isCatchPress = false;

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    final isKeyUp = event is RawKeyUpEvent;

    final bool handled;
    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      if(isKeyDown) {
        _keyboardVelo.x = -1;
        _keyboardAngle = _keyboardVelo.screenAngle();
      }else{
        _keyboardVelo.x = 0;
      }
      handled = true;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      if(isKeyDown) {
        _keyboardVelo.x = 1;
        _keyboardAngle = _keyboardVelo.screenAngle();
      }else{
        _keyboardVelo.x = 0;
      }
      handled = true;
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      if(isKeyDown) {
        _keyboardVelo.y = -1;
        _keyboardAngle = _keyboardVelo.screenAngle();
      }
      else{
        _keyboardVelo.y = 0;
      }
      handled = true;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      if(isKeyDown) {
        _keyboardVelo.y = 1;
        _keyboardAngle = _keyboardVelo.screenAngle();
      }
      else{
        _keyboardVelo.y = 0;
      }
      handled = true;
    } else {
      _keyboardVelo = Vector2.zero();
      handled = false;
    }

    if (event.logicalKey == LogicalKeyboardKey.space) {
      if(isKeyDown && !_isCatchPress ) {
        tryCatchTrash();
        _isCatchPress = true;
      }
      else if(isKeyUp){
        _isCatchPress = false;
      }
    }

    if (handled) {
      _handleKeyboardMovement(_keyboardVelo, _keyboardAngle);
      return false;
    } else {
      return super.onKeyEvent(event, keysPressed);
    }
  }

  void tryCatchTrash()
  {
    player.playCatchAnimation();
    player.tryRemoveTrash();
  }

  void handleJoystickMovement(Vector2 velocityDirection,double angle)
  {
     player.updateDirection(velocityDirection,angle);
  }

  void _handleKeyboardMovement(Vector2 velocityDirection,double angle)
  {
     player.updateDirection(velocityDirection,angle);
  }

}