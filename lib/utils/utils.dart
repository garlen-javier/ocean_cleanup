

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:ocean_cleanup/constants.dart';

class Utils{

  static Route nextPage(Widget screenWidget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screenWidget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1, 0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);

        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.ease,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  static double minuteToSeconds(double min) => min * 60;

  static String formatTime(double time) {
    time = (time > 0) ? time + 1 : time;
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