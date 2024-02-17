

import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/material.dart';

import '../bloc/player_movement/player_movement_bloc.dart';
import '../components/hud.dart';
import '../components/player/player.dart';
import '../worlds/game_world.dart';
import '../worlds/hud_world.dart';

class GameScene extends Forge2DGame {

  final PlayerMovementBloc playerMovementBloc;

  GameScene({
    required this.playerMovementBloc,
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
    await images.load("sprite2.png");
    await images.load("recycle_items.png");
    await images.load("onscreen_control_knob.png");
    await images.load("onscreen_control_base.png");
  }

  Future<void> loadWorlds() async {
    final gameWorld = GameWorld(playerMovementBloc:playerMovementBloc);
    final gameCamera = CameraComponent.withFixedResolution(
        width: GameWorld.worldSize.width,
        height: GameWorld.worldSize.height,
        world: gameWorld);

    gameCamera.viewfinder
      ..zoom = 0.5
      ..position = Vector2(GameWorld.worldSize.width, GameWorld.worldSize.height);
    //..anchor = Anchor.topLeft;

    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    final hudWorld = HudWorld(playerMovementBloc:playerMovementBloc);
    final hudCamera = CameraComponent.withFixedResolution(
      width: view.physicalSize.width / view.devicePixelRatio,
      height: view.physicalSize.height / view.devicePixelRatio,
      world: hudWorld,
    );

    // final hud = Hud(playerMovementBloc:playerMovementBloc);
    // await addAll([gameWorld,gameCamera,hud]);
     await addAll([gameWorld,gameCamera,hudWorld,hudCamera]);
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
    removeAll(children);
    Flame.images.clearCache();
    Flame.assets.clearCache();
    // TiledAtlas.clearCache();
  }

}
