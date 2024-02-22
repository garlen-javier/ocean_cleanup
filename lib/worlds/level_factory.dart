

import '../bloc/game_bloc_parameters.dart';
import '../levels/level_parameters.dart';
import 'game_world.dart';

class LevelFactory
{
  GameWorld createLevel(GameBlocParameters blocParameters,LevelParameters levelParameters)
  {
    GameWorld world = GameWorld(blocParameters: blocParameters);
    world.sharkCount = levelParameters.sharkCount;
    return world;
  }
}