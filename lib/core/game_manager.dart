
import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:ocean_cleanup/components/loading_game.dart';
import 'package:ocean_cleanup/levels/level_parameters.dart';
import 'package:ocean_cleanup/utils/utils.dart';
import 'package:ocean_cleanup/worlds/hud_world.dart';
import '../bloc/game/game_barrel.dart';
import '../bloc/game_bloc_parameters.dart';
import '../bloc/game_stats/game_stats_barrel.dart';
import '../components/player/player.dart';
import '../constants.dart';
import '../levels/levels.dart';
import '../scenes/game_scene.dart';
import '../utils/save_utils.dart';
import '../worlds/game_world.dart';
import 'game_result.dart';

class GameManager extends Component
{
  final GameScene gameScene;
  final GameBlocParameters blocParameters;
  GameManager({required this.gameScene,required this.blocParameters});

  final Levels _levels = Levels.instance;
  final List<AnimalType> _trappedAnimals = [];
  final List<AnimalType> _freedAnimals = [];
  final Map<AnimalType,TrashObjective> _trappedAnimalsMap = {};

  late LoadingGame? _loadingGame;
  Random rand = Random();
  GameWorld? _currentLevel;
  HudWorld? _hud;

  int _lastStageHealth = 0;
  double _totalStageRemainingTime = 0;

  int _currentLevelIndex = 0;
  int get currentLevelIndex => _currentLevelIndex;

  int _currentStageIndex = 0;
  int get currentStageIndex => _currentStageIndex;

  GamePhase _gamePhase = GamePhase.none;
  GamePhase get gamePhase => _gamePhase;

  LevelParameters get currentLevelParams => _levels.params[_currentLevelIndex];
  Map<AnimalType,TrashObjective> get trappedAnimalsMap => _trappedAnimalsMap;

  TrashObjective get currentTrashObjective => currentLevelParams.trashObjectives[_currentStageIndex];

  @override
  FutureOr<void> onLoad() async {
    await add(_loadingGame = LoadingGame());
    _initBlocListener();
    return super.onLoad();
  }

  void _removeLoadingScene()
  {
    if(_loadingGame != null)
    {
      _loadingGame?.removeFromParent();
      _loadingGame = null;
    }
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
          debugPrint("GameBloc Listener: $state");
          switch(state.phase)
          {
            case GamePhase.start:
              _removeLoadingScene();
              blocParameters.gameStatsBloc.defaultState();
              loadLevel(levelIndex: state.levelIndex,stageIndex: state.stageIndex);
              break;
            case GamePhase.playing:
              if(FlameAudio.bgm.audioPlayer.state == PlayerState.paused)
                 FlameAudio.bgm.resume();
              _currentLevel?.playerController?.enable = true;
              _currentLevel?.resumeTrashSpawn();
              break;
            case GamePhase.pause:
              if(FlameAudio.bgm.audioPlayer.state == PlayerState.playing)
                FlameAudio.bgm.pause();
              _currentLevel?.playerController?.enable = false;
              _currentLevel?.pauseTrashSpawn();
              break;
            case GamePhase.win:
              FlameAudio.bgm.stop();
              FlameAudio.play(pathSfxLevelWin);
              _saveFreeAnimalsIndex();
              _currentLevel?.playerController?.enable = false;
              _currentLevel?.pauseTrashSpawn();
              int nextLevel = _getNextLevelIndex();
              SaveUtils.instance.saveUnlockLevel(nextLevel);
              debugPrint("Win! " + state!.result.toString() );
              break;
            case GamePhase.gameOver:
               FlameAudio.bgm.stop();
               FlameAudio.play(pathSfxGameOver);
               _currentLevel?.playerController?.enable = false;
              _currentLevel?.pauseTrashSpawn();
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
          _updateResultWithState(state);
          if(!state.rescueFailed)
            _checkAnimalToFree();
        },
      ),
    );
  }

  Future<void> loadLevel({required int levelIndex,int stageIndex = 0}) async
  {
    if(!Utils.isLevelIndexValid(levelIndex))
    {
      throw RangeError.range(levelIndex, 0,maxStageLevel-1,"","Level Index $levelIndex is out of range");
    }

    debugPrint("Load Level Index: $levelIndex");
    debugPrint("Stage Index: $stageIndex");
    debugPrint("Phase: $gamePhase");
    _currentLevelIndex = levelIndex;
    _currentStageIndex = stageIndex;
    _totalStageRemainingTime = (stageIndex == 0) ? 0 : _totalStageRemainingTime;
    _cachedLevelParameters(levelIndex);
    await _changeWorldByLevel(levelIndex);
    await _loadHud();
    _currentLevel?.playerController?.enable = true;
    blocParameters.gameBloc.add(const GamePlaying());
    //_zoomFollowPlayer(gameScene.gameCamera, level.player);

    //Important: this could crash on web if the game is called at start so call this method in last line
    await _loadAudio();
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

    _currentLevel = GameWorld(gameManager: this, blocParameters: blocParameters);
    gameScene.gameCamera.world = _currentLevel;
    await gameScene.add(_currentLevel!);
  }

  Future<void> _loadHud() async {
    if(_hud != null) {
      gameScene.remove(_hud!);
    }

    _hud = HudWorld(gameManager: this, blocParameters: blocParameters,playerController: _currentLevel?.playerController);
    gameScene.hudCamera.world = _hud;
    await gameScene.add(_hud!);
  }

  void _cachedLevelParameters(int levelIndex)
  {
    LevelParameters params = _levels.params[levelIndex];
    _trappedAnimals.clear();
    _freedAnimals.clear();
    _trappedAnimalsMap.clear();

    List<dynamic> freedAnimalIndex = SaveUtils.instance.getFreedAnimalIndex();
    if(params.trappedAnimals != null) {
      params.trappedAnimals!.forEach((animal, animalMission) {
        //If the animal has been freed it should not come back unless reset all levels
        if(!freedAnimalIndex.contains(animal.index)) {
          _trappedAnimals.add(animal);
          _trappedAnimalsMap.putIfAbsent(animal, () => animalMission);
        }
      });
    }
  }

  int get initialHealth
  {
    int defHealth = defaultHealth;
    LevelParameters params = currentLevelParams;
    if(params.levelType == LevelType.boss && _currentStageIndex > 0)
    {
      defHealth = _lastStageHealth;
      blocParameters.gameStatsBloc.setHealth(defHealth);
    }
    else{
      List<dynamic> freedAnimalIndex = SaveUtils.instance.getFreedAnimalIndex();
      if(freedAnimalIndex.isNotEmpty) {
        defHealth+=freedAnimalIndex.length;
        blocParameters.gameStatsBloc.setHealth(defHealth);
      }
    }
    return defHealth;
  }

  TrashType randomizeTrashType()
  {
    LevelParameters params = currentLevelParams;
    if(_trappedAnimals.isNotEmpty)
    {
      double rng = rand.nextDouble();
      if(rng < params.animalTrashChance)
      {
        int i = rand.nextInt(_trappedAnimals.length);
        AnimalType chosenType = _trappedAnimals[i];
        return params.trappedAnimals![chosenType]!.trashType;
      }
    }
    else {
      if(currentTrashObjective.trashType != TrashType.any) {
        double rng = rand.nextDouble();
        if (rng < params.mainTrashChance) {
          return currentTrashObjective.trashType;
        }
      }
    }
    int rng = rand.nextInt(TrashType.values.length - 1) + 1;
    return TrashType.values[rng];
  }

  void _checkAnimalToFree()
  {
    LevelParameters params = currentLevelParams;
    if(params.trappedAnimals != null) {
      params.trappedAnimals!.forEach((animal, animalMission) {
        int trashCount = blocParameters.gameStatsBloc.trashCountByType(animalMission.trashType);
        int goalCount = animalMission.goal;
        if(trashCount == goalCount && _trappedAnimals.contains(animal))
        {
          debugPrint("Free Animal:$animal");
          _freedAnimals.add(animal);
          _trappedAnimals.remove(animal); //remove type for randomize trash
          blocParameters.gameStatsBloc.freeAnimal(animal);
          blocParameters.gameStatsBloc.addHealth(1);
          FlameAudio.play(pathSfxAnimalRescued);
        }
      });
    }
  }

  bool isCalled = false;
  void _updateResultWithState(GameStatsState state)
  {
    LevelParameters params = currentLevelParams;
    if(params.levelType == LevelType.normal)
    {
      int goal = params.trashObjectives.first.goal;
      int trashCount = blocParameters.gameStatsBloc.totalTrashCount();
      if(goal == trashCount)
      {
        GameResult result = _encodeGameResult(state.health,_hud!.remainingTime,params.levelType);
        blocParameters.gameBloc.add(GameWin(result));
      }
      else if(state.timerFinish || state.health == 0)
      {
        GameResult result = _encodeGameResult(state.health,_hud!.remainingTime,params.levelType);
        blocParameters.gameBloc.add(GameOver(result));
      }
    }
    else if(params.levelType == LevelType.boss)
    {
      TrashObjective objective = currentTrashObjective;
      int goal = objective.goal;
      int trashCount = blocParameters.gameStatsBloc.trashCountByType(objective.trashType);
      bool isGoal = goal == trashCount && !state.timerFinish;
      if(isGoal && _currentStageIndex == params.trashObjectives.length - 1)
      {
        _hud?.updateOctopusMeterValue(0);
        _totalStageRemainingTime+=_hud!.remainingTime;
        GameResult result = _encodeGameResult(state.health,_totalStageRemainingTime,params.levelType);
        blocParameters.gameBloc.add(GameWin(result));
      }
      else if(state.health == 0)
      {
        GameResult result = _encodeGameResult(state.health,_hud!.remainingTime,params.levelType);
        blocParameters.gameBloc.add(GameOver(result));
      }
      else if(isGoal)
      {
        nextStage(lastHealth: state.health);
      }
      else if(state.timerFinish)
      {
        _currentLevel?.octopus?.irritated = true;
      }
    }
  }

  GameResult _encodeGameResult(int health,double remainingTime,LevelType levelType) {
    return GameResult(
      levelIndex: currentLevelIndex,
      health: health,
      totalTrashCount: blocParameters.gameStatsBloc.totalTrashCount(),
      score: _getScore(remainingTime),
      remainingTime: remainingTime,
      levelType: levelType,
      freedAnimal: (_freedAnimals.isNotEmpty) ? _freedAnimals : null,
    );
  }

  int _getScore(double remainingTime)
  {
    int timeScore =  _hud!.remainingTime.floor() * 5;
    int animalScore = _freedAnimals.length * 100;
    return timeScore + animalScore;
  }

  Future<void> _preloadSfx() async {
    await FlameAudio.play(pathSfxLevelWin,volume: 0);
    await FlameAudio.play(pathSfxGameOver,volume: 0);
    await FlameAudio.play(pathSfxCatchTrash,volume: 0);
    await FlameAudio.play(pathSfxSwingNet,volume: 0);
    await FlameAudio.play(pathSfxReduceHealth,volume: 0);
    await FlameAudio.play(pathSfxAnimalRescued,volume: 0);
  }

  Future<void> _loadAudio() async {
    await _preloadSfx();
    if(!FlameAudio.bgm.isPlaying) {
      try {
        await FlameAudio.bgm.play(pathBgmGame);//This could error on hot restart/reload when bgm stop
      }catch(err)
      {
        debugPrint("BGM error $err");
      }
    }
  }

  void _saveFreeAnimalsIndex()
  {
    if(_freedAnimals.isNotEmpty)
    {
      for (AnimalType animal in _freedAnimals) {
        SaveUtils.instance.addFreeAnimal(animal);
      }
    }
  }

  int _getNextLevelIndex()
  {
    int levelIndex = _currentLevelIndex;
    if(levelIndex < maxStageLevel-1) {
      levelIndex++;
    }
    return levelIndex;
  }

  void nextStage({int lastHealth = 0})
  {
    LevelParameters params = currentLevelParams;
    if(_currentStageIndex < params.trashObjectives.length - 1) {
      _currentStageIndex++;
       debugPrint("New Stage Index: $_currentStageIndex");
      _totalStageRemainingTime+=_hud!.remainingTime;
      _hud?.startNewTimeLimit(currentTrashObjective.timeLimit);
      _hud?.startNewTrashGoal(currentTrashObjective.trashType, currentTrashObjective.goal);
      _hud?.updateOctopusMeterWithStage(_currentStageIndex, currentTrashObjective.timeLimit);
      _lastStageHealth = lastHealth + 2;
      blocParameters.gameStatsBloc.setHealth(_lastStageHealth);
      blocParameters.gameStatsBloc.timerReset();
      blocParameters.gameStatsBloc.resetTrashCount();
    }
  }

  //Currently clear the save game data such as freed animals
  void _resetAllLevels()
  {
    blocParameters.gameStatsBloc.defaultState();
    SaveUtils.instance.clearGameBox();
  }

}