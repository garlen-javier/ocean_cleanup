

import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import '../bloc/player_movement/player_movement_bloc.dart';
import '../scenes/game_scene.dart';

class HudWorld extends World with HasGameRef<GameScene>
{
  final PlayerMovementBloc playerMovementBloc;
  HudWorld({required this.playerMovementBloc}):super();

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

    PositionComponent component = PositionComponent();
    _joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: joyStickKnob ,
      ),
      background: SpriteComponent(
        sprite: joyStickBase ,
      ),
      position: Vector2(-gameRef!.size.x * 0.4,gameRef!.size.y * 0.35),
      priority: 4,
    );
    _joystick.scale = Vector2.all(0.7);
    await component.add(_joystick);
    await add(component);
  //  await add(_joystick);
  }

  Future<void> _showFPSDisplay() async {
    await add(FpsTextComponent(
      position: Vector2(gameRef!.size.x * 0.35,gameRef!.size.y * 0.4),
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    Vector2 velDir = Vector2(_joystick.delta.x.sign, _joystick.delta.y.sign);
    playerMovementBloc.move(velDir);
  }


}