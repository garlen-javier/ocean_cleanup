

import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/material.dart';
import '../bloc/bloc_parameters.dart';
import '../bloc/joystick_movement/joystick_movement_bloc.dart';
import '../components/player/player.dart';
import '../constants.dart';
import '../worlds/game_world.dart';
import '../worlds/hud_world.dart';

class GameScene extends Forge2DGame with HasKeyboardHandlerComponents{

  final BlocParameters blocParameters;

  GameScene({
    required this.blocParameters,
  });

  @override
  Color backgroundColor() => Colors.blueAccent;

  @override
  FutureOr<void> onLoad() async{
    await loadResources();
    await loadWorlds();
    return super.onLoad();
  }

  Future<void> loadResources() async {
    await images.loadAll([
      'sprite2.png',
      'recycle_items.png',
      'onscreen_control_knob.png',
      'onscreen_control_base.png',
      pathBagTrash,
      pathCutleries,
      pathPlasticCup,
      pathStraw,
      pathStyrofoam,
      pathWaterBottle,
      pathWaterGallon,
    ]);
  }

  Future<void> loadWorlds() async {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    final gameWorld = GameWorld(blocParameters: blocParameters);
    final gameCamera = CameraComponent.withFixedResolution(
         width: GameWorld.worldSize.width,
         height: GameWorld.worldSize.height,
        world: gameWorld);

    gameCamera.viewfinder
      ..zoom = 0.5
      ..position = Vector2(GameWorld.worldSize.width, GameWorld.worldSize.height);
     // ..anchor = Anchor.topLeft;

    final hudWorld = HudWorld(blocParameters: blocParameters);
    final hudCamera = CameraComponent.withFixedResolution(
      width: view.physicalSize.width / view.devicePixelRatio,
      height: view.physicalSize.height / view.devicePixelRatio,
      world: hudWorld,
    );


     await addAll([gameWorld,gameCamera, hudWorld ,hudCamera]);
    //_zoomFollowPlayer(gameCamera, gameWorld.player);
  }

  void _zoomFollowPlayer(CameraComponent cam,Player player)
  {
    cam.viewfinder.zoom = 1;
    cam.setBounds(GameWorld.bounds);
    cam.follow(player, maxSpeed: 450);
  }

  @override
  void onRemove() {
    super.onRemove();
    //removeAll(children);
    //Flame.images.clearCache();
    //Flame.assets.clearCache();
    //TiledAtlas.clearCache();
  }

}
