

import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';
import '../../bloc/game_bloc_parameters.dart';
import '../../constants.dart';
import '../../mixins/update_mixin.dart';
import '../../scenes/game_scene.dart';
import '../../worlds/game_world.dart';
import '../player/player_controller.dart';

class HudMobileControl extends PositionComponent with HasGameRef<GameScene>,UpdateMixin
{
  final GameBlocParameters blocParameters;
  final PlayerController? playerController;
  HudMobileControl({required this.blocParameters,this.playerController});

  JoystickComponent? _joystick;
  late Vector2 _gameSize;

  @override
  FutureOr<void> onLoad() async {
    _gameSize = screenRatio.toVector2();
    _showJoyStick();
    _showCatchButton();
    return super.onLoad();
  }

  Future<void> _showJoyStick() async {
    Image knob = gameRef.images.fromCache(pathJoystickKnob);
    Image base = gameRef.images.fromCache(pathJoystickBase);

    Sprite joyStickKnob = Sprite(knob);
    Sprite joyStickBase = Sprite(base);

    PositionComponent component = PositionComponent();
    _joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: joyStickKnob ,
      ),
      background: SpriteComponent(
        sprite: joyStickBase ,
      ),
      position: Vector2(-_gameSize.x * 0.27,_gameSize.y * 0.22 ),
    );
   // _joystick!.scale = Vector2.all(0.7);
    await component.add(_joystick!);
    await add(component);
  }

  Future<void> _showCatchButton() async {
    final spriteUp = Sprite(gameRef.images.fromCache(pathCatchButtonDefault));
    final spriteDown = Sprite(gameRef.images.fromCache(pathCatchButtonPressed));
    final button = SpriteButtonComponent(
      button: spriteUp,
      buttonDown: spriteDown,
      onPressed: () {
        playerController?.tryCatchTrash();
      },
      position: Vector2(_gameSize.x * 0.24,_gameSize.y * 0.17),
    );
    await add(button);
  }

  @override
  void runUpdate(double dt) {
    if(_joystick != null)
      playerController?.handleJoystickMovement(_joystick!.relativeDelta,_joystick!.delta.screenAngle());
  }


}