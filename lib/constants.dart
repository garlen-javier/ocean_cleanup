

import 'levels/level_parameters.dart';

const bool isTesterMode = false;
const bool isRelease = false;

const int defaultHealth = 3;
const int maxHealth = 7;
const int playerPriority = 2;
const int maxStageLevel = 5;

const String pathPlayer = "player.png";

const String pathShark = "enemies/shark.png";

const String pathBagTrash = "trashes/bag_trash.png";
const String pathCutleries = "trashes/cutleries.png";
const String pathPlasticCup = "trashes/plastic_cup.png";
const String pathStraw = "trashes/straw.png";
const String pathStyrofoam = "trashes/styrofoam.png";
const String pathWaterBottle = "trashes/water_bottle.png";
const String pathWaterGallon = "trashes/water_gallon.png";

const String pathCrab = "animals/crab.png";
const String pathDolphin = "animals/dolphin.png";
const String pathSeal = "animals/whale.png";
const String pathTurtle = "animals/turtle.png";

const String pathRescueComplete = "rescue_complete.png";
const String pathRescueFailed = "rescue_failed.png";
const String pathAnimalFrame = "animal_frame.png";

const String pathFishNet = "fish_net.png";
const String pathHealth = "health.png";

const String pathJoystickBase = "onscreen_control_base.png";
const String pathJoystickKnob = "onscreen_control_knob.png";
const String pathCatchButtonDefault = "catch_button_default.png";
const String pathCatchButtonPressed = "catch_button_pressed.png";

const Map<TrashType,String> trashPathMap = {
  TrashType.bagTrash : pathBagTrash,
  TrashType.cutleries : pathCutleries,
  TrashType.plasticCup : pathPlasticCup,
  TrashType.straw : pathStraw,
  TrashType.styroFoam : pathStyrofoam,
  TrashType.waterBottle : pathWaterBottle,
  TrashType.waterGallon : pathWaterGallon,
};

const Map<AnimalType,String> animalPathMap = {
  AnimalType.crab : pathCrab,
  AnimalType.seaTurtle : pathTurtle,
  AnimalType.seal : pathSeal,
  AnimalType.dolphin : pathDolphin,
};

//#region Audio
const String pathBgmGame = "bgm/bgm_game.mp3";
const String pathSfxCatchTrash = "sfx/catching_trash.wav";
const String pathSfxSwingNet = "sfx/swinging_net.mp3";
const String pathSfxReduceHealth = "sfx/reduced_health.wav";
const String pathSfxGameOver = "sfx/game_over.mp3";
const String pathSfxLevelWin = "sfx/level_win.mp3";
const String pathSfxAnimalRescued = "sfx/animal_rescued.mp3";
//#endregion
