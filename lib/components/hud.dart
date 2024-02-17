

import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import '../bloc/player_movement/player_movement_bloc.dart';
import '../scenes/game_scene.dart';


/// NOTE: Don't use this, I'm testing something here
class Hud extends PositionComponent with HasGameRef<GameScene>
{
  final PlayerMovementBloc playerMovementBloc;
  Hud({required this.playerMovementBloc}):super(priority: 0x7fffffff);

  late final JoystickComponent _joystick;

  @override
  FutureOr<void> onLoad() async{
    await _showJoyStick();
    await _showFPSDisplay();
    return super.onLoad();
  }

  Future<void> _showJoyStick() async {
    Image knob = gameRef.images.fromCache("onscreen_control_knob.png");
    Image base = gameRef.images.fromCache("onscreen_control_base.png");

    Sprite joyStickKnob = Sprite(knob);
    Sprite joyStickBase = Sprite(base);

    _joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: joyStickKnob ,
      ),
      background: SpriteComponent(
        sprite: joyStickBase ,
      ),
     // position: Vector2(gameRef!.size.x * 0.1,gameRef!.size.y * 0.85),
    );
    _joystick.scale = Vector2.all(0.7);

    HudMarginComponent hud = HudMarginComponent(size: Vector2(100,100), margin: const cupertino.EdgeInsets.only(left: 50, top: 50));
    await hud.add(_joystick);
    await add(hud);
   //  await add(_joystick);
  }

  Future<void> _showFPSDisplay() async {
    await add(FpsTextComponent(
     // position: Vector2(gameRef!.size.x * 0.85,gameRef!.size.y * 0.85),
      position: Vector2(20,20),
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    //Vector2 velDir = Vector2(_joystick.delta.x.sign, _joystick.delta.y.sign);
    //playerMovementBloc.move(velDir);
  }

  @override
  void onGameResize(Vector2 size) {
    size = gameRef.size;
    super.onGameResize(size);
  }

}