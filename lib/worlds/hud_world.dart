

import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:ocean_cleanup/utils/utils.dart';
import '../bloc/game_bloc_parameters.dart';
import '../bloc/player_stats/player_stats_barrel.dart';
import '../components/hud/hud_stats.dart';
import '../components/hud/hud_timer.dart';
import '../scenes/game_scene.dart';
import 'package:flutter/material.dart' as material;

class HudWorld extends World with HasGameRef<GameScene>
{
  final GameBlocParameters blocParameters;
  HudWorld({required this.blocParameters}):super();

  JoystickComponent? _joystick;
  late Vector2 _gameSize;

  @override
  FutureOr<void> onLoad() async{
    _gameSize = gameRef!.size;
    if (Utils.isMobile)
      await _showJoyStick();

    await _showTimer();
    await _showGameStats();
    await _showFPSDisplay();
    return super.onLoad();
  }

  Future<void> _showTimer() async {
    await add(HudTimer(timeLimit: 20,pos:Vector2(-20,-_gameSize.y * 0.48)));
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
    _joystick!.scale = Vector2.all(0.7);
    await component.add(_joystick!);
    await add(component);
  }

  Future<void> _showFPSDisplay() async {
    await add(FpsTextComponent(
      textRenderer: TextPaint(
        style: const material.TextStyle(color: material.Colors.black, fontSize: 20),
      ),
       position: Vector2(_gameSize.x * 0.35,_gameSize.y * 0.4),
    ));
  }

  Future<void> _showGameStats() async {
    HudStats stats = HudStats();
    await add(stats);
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<PlayerStatsBloc, PlayerStatsState>.value(
            value: blocParameters.playerStatsBloc,
          ),
        ],
        children: [
          stats,
        ],
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if(_joystick != null)
      blocParameters.joystickMovementBloc.move(_joystick!.relativeDelta,_joystick!.delta.screenAngle());
  }


  @override
  void onGameResize(Vector2 size) {
    _gameSize = size;
    super.onGameResize(size);
  }


}