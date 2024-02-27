
import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:ocean_cleanup/game_result.dart';
import 'package:ocean_cleanup/levels/level_parameters.dart';
import 'package:ocean_cleanup/worlds/hud_world.dart';
import 'bloc/game/game_barrel.dart';
import 'bloc/game_bloc_parameters.dart';
import 'bloc/game_stats/game_stats_barrel.dart';
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
  final List<AnimalType> _trappedAnimals = [];
  final List<AnimalType> _freedAnimals = [];
  final Set<TrashType> _trashTypes = {};

  Random rand = Random();
  GameWorld? _currentLevel;
  HudWorld? _hud;
  int _currentLevelIndex = 0;
  final double _animalTrashChance = 0.6;

  LevelParameters levelParameters(int levelIndex) => _levels.params[levelIndex];
  int get currentLevelIndex => _currentLevelIndex;
  Set<TrashType> get currentTrashTypes => _trashTypes; ///To display current trash in UI
  GamePhase _gamePhase = GamePhase.none;
  GamePhase get gamePhase => _gamePhase;

  @override
  FutureOr<void> onLoad() async {
    await _initBlocListener();
    return super.onLoad();
  }

  Future<void> _initBlocListener() async {

    //GameState
    await add(
      FlameBlocListener<GameBloc, GameState>(
        listenWhen: (previousState, newState) {
          return previousState != newState;
        },
        onNewState: (state)  {
          _gamePhase = state.phase;
          debugPrint(state.toString());
          switch(state.phase)
          {
            case GamePhase.win:
              debugPrint("Win! " + state!.result.toString() );
              break;
            case GamePhase.gameOver:
              debugPrint("GameOver!" + state!.result.toString() );
              break;
            default:
              break;
          }
        },
      ),
    );

    //Game Stats
    await add(
      FlameBlocListener<GameStatsBloc, GameStatsState>(
        listenWhen: (previousState, newState) {
          return true;
        },
        onNewState: (state) {
          LevelParameters params = levelParameters(currentLevelIndex);
          if(params.levelType == LevelType.normal)
          {
            int goal = params.trashObjectives.first.goal;
            int trashCount = blocParameters.gameStatsBloc.totalTrashCount();
            if(goal == trashCount)
            {
              GameResult result = _encodeGameResult(state.health, params.levelType);
              blocParameters.gameBloc.add(GameWin(result));
            }
            else if(state.timerFinish || state.health == 0)
            {
              GameResult result = _encodeGameResult(state.health, params.levelType);
              blocParameters.gameBloc.add(GameOver(result));
            }
          }

          if(!state.rescueFailed)
          {
            _checkAnimalToFree();
          }
          else if(state.rescueFailed){
            //TODO: failed rescue/can update ui?
          }
        },
      ),
    );
  }

  Future<void> loadLevel(int levelIndex) async
  {
    debugPrint("Load Level Index: " + levelIndex.toString());
    _currentLevelIndex = levelIndex;
    _cachedLevelParameters(levelIndex);
    await _changeWorldByLevel(levelIndex);
    await _loadHud();
    //_zoomFollowPlayer(gameScene.gameCamera, level.player);
  }

  void _zoomFollowPlayer(CameraComponent cam,Player player)
  {
    cam.viewfinder.zoom = 1;
    cam.setBounds(GameWorld.bounds);
    cam.follow(player, maxSpeed: 450);
  }

  Future<void> _changeWorldByLevel(int levelIndex) async {
    if(_currentLevel != null) {
      gameScene.remove(_currentLevel!);
    }

    _currentLevel = _levelFactory.createLevel(this,levelIndex,blocParameters);
    gameScene.gameCamera.world = _currentLevel;
    await gameScene.add(_currentLevel!);
  }

  Future<void> _loadHud() async {
    if(_hud != null) {
      gameScene.remove(_hud!);
    }

    _hud = HudWorld(gameManager: this, blocParameters: blocParameters);
    gameScene.hudCamera.world = _hud;
    await gameScene.add(_hud!);
  }

  void _cachedLevelParameters(int levelIndex)
  {
    LevelParameters params = levelParameters(levelIndex);
    _trappedAnimals.clear();
    _freedAnimals.clear();
    _trashTypes.clear();
    _trashTypes.add(TrashType.any);
    if(params.trappedAnimals != null) {
      params.trappedAnimals!.forEach((animal, animalMission) {
        _trappedAnimals.add(animal);
        _trashTypes.add(animalMission.trashType);
      });
    }
  }

  TrashType randomizeTrashType()
  {
    if(_trappedAnimals.isNotEmpty)
    {
      double rng = rand.nextDouble();
      if(rng < _animalTrashChance)
      {
        int i = rand.nextInt(_trappedAnimals.length);
        AnimalType chosenType = _trappedAnimals[i];
        LevelParameters params = levelParameters(currentLevelIndex);
        return params.trappedAnimals![chosenType]!.trashType;
      }
    }
    int rng = rand.nextInt(TrashType.values.length - 1) + 1;
    return TrashType.values[rng];
  }

  void _checkAnimalToFree()
  {
    LevelParameters params = levelParameters(currentLevelIndex);
    if(params.trappedAnimals != null) {
      params.trappedAnimals!.forEach((animal, animalMission) {
        int trashCount = blocParameters.gameStatsBloc.trashCountByType(animalMission.trashType);
        int goalCount = animalMission.goal;
        if(trashCount == goalCount && _trappedAnimals.contains(animal))
        {
          //free animal
          _freedAnimals.add(animal);
          _trappedAnimals.remove(animal); //remove type for randomize trash
        }
      });
    }
  }

  GameResult _encodeGameResult(int health,LevelType levelType) {
    return GameResult(
      levelIndex: currentLevelIndex,
      health: health,
      remainingTime: _hud!.remainingTime,
      levelType: levelType,
      freedAnimal: (_freedAnimals.isNotEmpty) ? _freedAnimals : null,
    );
  }


}