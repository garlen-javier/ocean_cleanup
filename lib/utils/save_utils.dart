

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ocean_cleanup/levels/level_parameters.dart';
import 'package:ocean_cleanup/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

const String hiveGameBoxKey = "hiveGameBoxKey";
const String hiveFreedAnimalsKey = "hiveFreedAnimalsKey";

class SaveUtils{

  static final SaveUtils _instance = SaveUtils.constructor();
  SaveUtils.constructor();
  static SaveUtils get instance => _instance;

  Box get _gameBox => Hive.box(hiveGameBoxKey);

  Future<void> loadData() async {
    await _loadHive();
    await _loadBoxes();
    debugPrint("Hive Loading Done!");
  }

  Future<void> _loadHive() async {
    if(Utils.isMobile) {
      Directory appDir = await getApplicationDocumentsDirectory();
      String appPath = appDir.path;
      Hive.init(appPath);
    }
    else{
      Hive.initFlutter();
    }
  }

  Future<void> _loadBoxes() async {
    await Hive.openBox(hiveGameBoxKey);
  }

  void addFreeAnimal(AnimalType animal)
  {
    String key = hiveFreedAnimalsKey;
    List<dynamic> animals = _gameBox.get(key,defaultValue:<dynamic>[]);
    if(!animals.contains(animal.index)) {
      animals.add(animal.index);
      _gameBox.put(key, animals);
    }
  }

  List<dynamic> getFreedAnimalIndex()
  {
    String key = hiveFreedAnimalsKey;
    List<dynamic> list = _gameBox.get(key,defaultValue:<dynamic>[]);
    return list;
  }

  void clearGameBox()
  {
    _gameBox.clear();
  }






}