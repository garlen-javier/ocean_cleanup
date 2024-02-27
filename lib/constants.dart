

import 'levels/level_parameters.dart';

const int defaultHealth = 3;
const int playerPriority = 2;

const String pathPlayer = "player.png";

const String pathShark = "enemies/shark.png";

const String pathBagTrash = "trashes/bag_trash.png";
const String pathCutleries = "trashes/cutleries.png";
const String pathPlasticCup = "trashes/plastic_cup.png";
const String pathStraw = "trashes/straw.png";
const String pathStyrofoam = "trashes/styrofoam.png";
const String pathWaterBottle = "trashes/water_bottle.png";
const String pathWaterGallon = "trashes/water_gallon.png";

const String pathDolphin = "animals/dolphin_sprite.png";

const String pathFishNet = "fish_net.png";
const String pathHealth = "health.png";

const Map<TrashType,String> trashPathMap = {
  TrashType.bagTrash : pathBagTrash,
  TrashType.cutleries : pathCutleries,
  TrashType.plasticCup : pathPlasticCup,
  TrashType.straw : pathStraw,
  TrashType.styroFoam : pathStyrofoam,
  TrashType.waterBottle : pathWaterBottle,
  TrashType.waterGallon : pathWaterGallon,
};
