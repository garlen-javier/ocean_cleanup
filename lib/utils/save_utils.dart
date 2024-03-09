import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ocean_cleanup/levels/level_parameters.dart';
import 'package:ocean_cleanup/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String hiveGameBoxKey = "hiveGameBoxKey";

//Keys
const String hiveFreedAnimalsKey = "hiveFreedAnimalsKey";
const String hiveUnlockLevelKey = "hiveUnlockLevelKey";

class SaveUtils {
  static final SaveUtils _instance = SaveUtils.constructor();
  SaveUtils.constructor();
  static SaveUtils get instance => _instance;

  Box get _gameBox => Hive.box(hiveGameBoxKey);
  bool _isLoaded = false;

  Future<void> loadData() async {
    await _loadHive();
    await _loadBoxes();
    _isLoaded = true;
    debugPrint("Hive Loading Done!");
  }

  Future<void> _loadHive() async {
    if (Utils.isMobile) {
      Directory appDir = await getApplicationDocumentsDirectory();
      String appPath = appDir.path;
      Hive.init(appPath);
    } else {
      Hive.initFlutter();
    }
  }

  Future<void> _loadBoxes() async {
    await Hive.openBox(hiveGameBoxKey);
  }

  ///Should save the level the would get unlock
  void saveUnlockLevel(int levelIndex)
  {
    assertMessage();
    String key = hiveUnlockLevelKey;
    int lastIndex = _gameBox.get(key, defaultValue: 0);
    if (levelIndex > lastIndex) _gameBox.put(key, levelIndex);
  }

  int get getUnlockedLevel {
    assertMessage();
    return _gameBox.get(hiveUnlockLevelKey,defaultValue:0);
  }

  void addFreeAnimal(AnimalType animal)
  {
    assertMessage();
    String key = hiveFreedAnimalsKey;
    List<dynamic> animals = _gameBox.get(key, defaultValue: <dynamic>[]);
    if (!animals.contains(animal.index)) {
      animals.add(animal.index);
      _gameBox.put(key, animals);
    }
  }

  List<dynamic> getFreedAnimalIndex()
  {
    assertMessage();
    String key = hiveFreedAnimalsKey;
    List<dynamic> list = _gameBox.get(key, defaultValue: <dynamic>[]);
    return list;
  }

  void clearGameBox()
  {
    assertMessage();
    _gameBox.clear();
  }

  void assertMessage()
  {
    assert(_isLoaded,"SaveUtils should be loaded first");
  }

  void saveTutorialStatus(String tuto , bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(tuto, status);
  }

  Future<bool> getTutorialStatus(String tuto) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(tuto) ?? false;
  }
}




