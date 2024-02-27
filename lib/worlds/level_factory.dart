

import 'package:ocean_cleanup/core/game_manager.dart';

import '../bloc/game_bloc_parameters.dart';
import '../levels/level_parameters.dart';
import 'game_world.dart';

class LevelFactory
{

  GameWorld createLevel(GameManager gameManager,int levelIndex,GameBlocParameters blocParameters)
  {
    LevelParameters params = gameManager.levelParameters(levelIndex);
    GameWorld world = GameWorld(gameManager: gameManager, blocParameters: blocParameters);
    world.sharkCount = params.sharkCount;
    return world;
  }
}