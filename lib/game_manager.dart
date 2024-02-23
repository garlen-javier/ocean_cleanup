
import 'dart:async';
import 'dart:math';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:ocean_cleanup/levels/level_parameters.dart';

import 'bloc/game_bloc_parameters.dart';
import 'bloc/player_stats/player_stats_barrel.dart';
import 'components/player/player.dart';
import 'levels/levels.dart';
import 'scenes/game_scene.dart';
import 'worlds/game_world.dart';
import 'worlds/level_factory.dart';

class GameManager extends Component
{
  final GameScene gameScene;
  final GameBlocParameters blocParameters;
  GameManager({required this.gameScene,required this.blocParameters});

  final LevelFactory _levelFactory = LevelFactory();
  final Levels _levels = Levels();
  late final List<TrappedAnimal> _animalType = [];

  Random rand = Random();
  World? _currentLevel;
  int _currentLevelIndex = 0;
  double _animalTrashChance = 0.6;

  LevelParameters levelParameters(int levelIndex) => _levels.params[levelIndex];
  int get currentLevelIndex => _currentLevelIndex;

  @override
  FutureOr<void> onLoad() async {
    _initBlocListener();
    return super.onLoad();
  }

  Future<void> _initBlocListener() async {
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<PlayerStatsBloc, PlayerStatsState>.value(
            value: blocParameters.playerStatsBloc,
          ),
        ],
        children: [
          this,
        ],
      ),
    );
  }

  Future<void> loadLevel(int levelIndex) async
  {
    _currentLevelIndex = levelIndex;
    _cachedAnimalsByLevel(levelIndex);
    await _changeWorldByLevel(levelIndex);
    //_zoomFollowPlayer(gameScene.gameCamera, level.player);
  }

  void _zoomFollowPlayer(CameraComponent cam,Player player)
  {
    cam.viewfinder.zoom = 1;
    cam.setBounds(GameWorld.bounds);
    cam.follow(player, maxSpeed: 450);
  }

  Future<void> _changeWorldByLevel(int levelIndex) async {
    if(_currentLevel != null)
      gameScene.remove(_currentLevel!);

    GameWorld level = _levelFactory.createLevel(this,levelIndex,blocParameters);
    _currentLevel = level;
    gameScene.gameCamera.world = _currentLevel;
    await gameScene.add(_currentLevel!);
  }

  void _cachedAnimalsByLevel(int levelIndex)
  {
    LevelParameters params = levelParameters(levelIndex);
    _animalType.clear();
    if(params.trappedAnimals != null) {
      params.trappedAnimals!.forEach((animal, animalMission) {
        _animalType.add(animal);
      });
    }
  }

  TrashType randomizeTrashType()
  {
    if(_animalType.isNotEmpty)
    {
      double rng = rand.nextDouble();
      if(rng < _animalTrashChance)
      {
        int i = rand.nextInt(_animalType.length);
        TrappedAnimal chosenType = _animalType[i];
        LevelParameters params = levelParameters(currentLevelIndex);
        return params.trappedAnimals![chosenType]!.trashType;
      }
    }
    int rng = rand.nextInt(TrashType.values.length - 1) + 1;
    return TrashType.values[rng];
  }


}