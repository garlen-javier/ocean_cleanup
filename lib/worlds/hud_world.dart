

import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import '../bloc/joystick_movement/joystick_movement_bloc.dart';
import '../scenes/game_scene.dart';

class HudWorld extends World with HasGameRef<GameScene>
{
  final JoystickMovementBloc joystickMovementBloc;
  HudWorld({required this.joystickMovementBloc}):super();

  late final JoystickComponent _joystick;
  late Vector2 _gameSize;

  @override
  FutureOr<void> onLoad() async{
    _gameSize = gameRef!.size;
    await _showJoyStick();
    await _showFPSDisplay();
    return super.onLoad();
  }

  Future<void> _showJoyStick() async {
    Image knob = gameRef.images.fromCache("onscreen_control_knob.png");
    Image base = gameRef.images.fromCache("onscreen_control_base.png");

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
      position: Vector2(-_gameSize.x * 0.4,_gameSize.y * 0.35),
    );
    _joystick.scale = Vector2.all(0.7);
    await component.add(_joystick);
    await add(component);
  }

  Future<void> _showFPSDisplay() async {
    await add(FpsTextComponent(
       position: Vector2(_gameSize.x * 0.35,_gameSize.y * 0.4),
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    Vector2 velDir = Vector2(_joystick.delta.x.sign, _joystick.delta.y.sign);
    joystickMovementBloc.move(velDir);
  }

  @override
  void onGameResize(Vector2 size) {
    _gameSize = size;
    super.onGameResize(size);
  }


}