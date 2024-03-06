

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
  bool enable = false;

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    final isKeyUp = event is RawKeyUpEvent;

    final bool handled;
    final bool isLeft = event.logicalKey == LogicalKeyboardKey.keyA || event.logicalKey == LogicalKeyboardKey.arrowLeft;
    final bool isRight = event.logicalKey == LogicalKeyboardKey.keyD || event.logicalKey == LogicalKeyboardKey.arrowRight;
    final bool isUp = event.logicalKey == LogicalKeyboardKey.keyW || event.logicalKey == LogicalKeyboardKey.arrowUp;
    final bool isDown = event.logicalKey == LogicalKeyboardKey.keyS || event.logicalKey == LogicalKeyboardKey.arrowDown;

    if (isLeft) {
      _changeXDirection(isKeyDown, -1);
      handled = true;
    } else if (isRight) {
      _changeXDirection(isKeyDown, 1);
      handled = true;
    } else if (isUp) {
      _changeYDirection(isKeyDown, -1);
      handled = true;
    } else if (isDown) {
      _changeYDirection(isKeyDown, 1);
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

  void _changeXDirection(bool isKeyDown,double dir)
  {
    if(isKeyDown) {
      _keyboardVelo.x = dir;
      _keyboardAngle = _keyboardVelo.screenAngle();
    }
    else {
      _keyboardVelo.x = 0;
    }
  }

  void _changeYDirection(bool isKeyDown,double dir)
  {
    if(isKeyDown) {
      _keyboardVelo.y = dir;
      _keyboardAngle = _keyboardVelo.screenAngle();
    }else{
      _keyboardVelo.y = 0;
    }
  }

  void tryCatchTrash()
  {
    if(!enable)
      return;

    player.playCatchAnimation();
    player.tryRemoveTrash();
  }

  void handleJoystickMovement(Vector2 velocityDirection,double angle)
  {
    if(!enable)
      return;

    player.updateDirection(velocityDirection,angle);
  }

  void _handleKeyboardMovement(Vector2 velocityDirection,double angle)
  {
    if(!enable)
      return;

     player.updateDirection(velocityDirection,angle);
  }

}