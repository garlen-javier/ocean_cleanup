

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:ocean_cleanup/constants.dart';

class Utils{

  static double minuteToSeconds(double min) => min * 60;

  static String formatTime(double time) {
    final minutes = (time / 60).floor();
    final seconds = (time % 60).floor();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  static bool isLevelIndexValid(int levelIndex) => levelIndex < maxStageLevel;

  static bool get isMobile {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isIOS || Platform.isAndroid;
    }
  }

  static bool get isDesktop {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isLinux || Platform.isFuchsia || Platform.isWindows || Platform.isMacOS;
    }
  }
}