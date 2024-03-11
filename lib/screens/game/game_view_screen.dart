import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocean_cleanup/bloc/game/game_barrel.dart';
import 'package:ocean_cleanup/components/popups/gameover_popup.dart';
import 'package:ocean_cleanup/components/popups/pause_popup.dart';
import 'package:ocean_cleanup/components/popups/victory_popup.dart';
import 'package:ocean_cleanup/core/game_result.dart';
import 'package:ocean_cleanup/core/game_scene.dart';
import 'package:ocean_cleanup/levels/level_parameters.dart';
import 'package:ocean_cleanup/screens/levels/levels_screen.dart';
import '../../bloc/game_bloc_parameters.dart';
import '../../bloc/game_stats/game_stats_barrel.dart';
import '../../utils/config_size.dart';

class GameViewScreen extends StatefulWidget {
  const GameViewScreen({super.key});

  @override
  State<GameViewScreen> createState() => _GameViewScreenState();
}

class _GameViewScreenState extends State<GameViewScreen> {
  late GameBloc _gameBloc;
  GameScene? _game;

  @override
  void initState() {
    _gameBloc = BlocProvider.of<GameBloc>(context);
    super.initState();
  }

  BlocListener<GameBloc, GameState> _gameListener() {
    return BlocListener<GameBloc, GameState>(
      bloc: _gameBloc,
      listenWhen: (previousState, newState) {
        return previousState != newState;
      },
      listener: (BuildContext context, GameState state) {
        debugPrint("GameViewScreen GameBloc : $state");
        switch (state.phase) {
          case GamePhase.none:
            _game?.overlays.removeAll([
              "PausePopup",
              "VictoryPopup",
              "GameoverPopup",
              "AnimalPopup",
            ]);
            break;
          case GamePhase.start:
            _game?.overlays.removeAll([
              "PausePopup",
              "VictoryPopup",
              "GameoverPopup",
              "AnimalPopup",
            ]);
            break;
          case GamePhase.playing:
            _game?.overlays.remove("PausePopup");
            break;
          case GamePhase.pause:
            _game?.overlays.add("PausePopup");
            break;
          case GamePhase.win:
            _game?.overlays.add("VictoryPopup");
            if (state.result?.freedAnimal != null) {
              _game?.overlays.add("AnimalPopup");
            }
            break;
          case GamePhase.gameOver:
            _game?.overlays.add("GameoverPopup");
            break;
          default:
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Object? obj = ModalRoute.of(context)?.settings.arguments;
    int levelIndex = (obj != null) ? obj as int : 0;

    return MultiBlocListener(
      listeners: [
        _gameListener(),
      ],
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop) {
            _gameBloc.add(const GamePause());
          }
        },
        child: GameWidget(
          focusNode: FocusNode(),
          game: _game = GameScene(
              levelIndex: levelIndex,
              blocParameters: GameBlocParameters(
                gameBloc: context.read<GameBloc>(),
                gameStatsBloc: context.read<GameStatsBloc>(),
              )),
          overlayBuilderMap: {
            'PausePopup': _pauseOverlay(),
            'VictoryPopup': _victoryOverlay(),
            'GameoverPopup': _gameoverOverlay(),
            'AnimalPopup': _animalOverlay(),
          },
        ),
      ),
    );
  }

  //#region Overlay Popups

  Widget Function(BuildContext, GameScene) _pauseOverlay() {
    return (context, game) {
      return showPausePopup(context, onPressContinue: () {
        _game?.overlays.remove("PausePopup");
        _gameBloc.add(const GameResume());
      }, onPressRestart: () {
        _game?.overlays.remove("PausePopup");
        _gameBloc.add(const GameRestart());
      }, onPressQuit: () {
        _game?.overlays.remove("PausePopup");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LevelsScreen()));
      });
    };
  }

  Widget Function(BuildContext, GameScene) _victoryOverlay() {
    return (context, game) {
      return BlocBuilder<GameBloc, GameState>(
          buildWhen: (previousState, state) {
        return previousState != state;
      }, builder: (context, state) {
        debugPrint("showGameoverPopup: ${state.result}");
        GameResult? result = state.result;
        return (result != null)
            ? showVictoryPopup(context, result.levelIndex, result.score,
                onPressNext: () {
                _game?.overlays.remove("VictoryPopup");
                _gameBloc.add(const GameStartNext());
              }, onPressRetry: () {
                _game?.overlays.remove("VictoryPopup");
                _gameBloc.add(const GameRestart());
              })
            : Container();
      });
    };
  }

  Widget Function(BuildContext, GameScene) _gameoverOverlay() {
    return (context, game) {
      return BlocBuilder<GameBloc, GameState>(
          buildWhen: (previousState, state) {
        return previousState != state;
      }, builder: (context, state) {
        debugPrint("showGameOverPopup: ${state.result}");
        GameResult? result = state.result;
        return (result != null)
            ? showGameOverPopup(
                context,
                result.levelIndex,
                result.score,
                onPressRestart: () {
                  _game?.overlays.remove("GameoverPopup");
                  _gameBloc.add(const GameRestart());
                },
                onPressBack: () {
                  _game?.overlays.remove("GameoverPopup");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LevelsScreen(),
                    ),
                  );
                },
              )
            : Container();
      });
    };
  }

  Widget Function(BuildContext, GameScene) _animalOverlay() {
    return (context, game) {
      return BlocBuilder<GameBloc, GameState>(
          buildWhen: (previousState, state) {
        return previousState != state;
      }, builder: (context, state) {
        debugPrint("showAnimalPopup: ${state.result}");
        GameResult? result = state.result;
        return (result != null)
            ? _animalPopup(freedAnimals: result.freedAnimal)
            : Container();
      });
    };
  }

  Dialog _animalPopup({List<AnimalType>? freedAnimals = const []}) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Image.asset(
            freedAnimals!.contains(AnimalType.crab)
                ? 'assets/images/freed_animals/Crab.png'
                : freedAnimals.contains(AnimalType.seaTurtle)
                    ? 'assets/images/freed_animals/Turtle.png'
                    : 'assets/images/freed_animals/Whale.png',
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Continue Playing",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "wendyOne",
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //#endregion
}
