import 'package:flutter/material.dart';
import 'package:ocean_cleanup/bloc/game/game_bloc.dart';
import 'package:ocean_cleanup/bloc/game/game_event.dart';
import 'package:ocean_cleanup/screens/levels/levels_screen.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

Dialog showPausePopup(BuildContext context,{VoidCallback? onPressContinue,VoidCallback? onPressRestart,VoidCallback? onPressQuit}) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(color: Colors.yellow, width: 5),
        ),
        backgroundColor: const Color(0xFF6874ca),
        child: SizedBox(
          width: SizeConfig.screenWidth / 2,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Pause",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.largeText1,
                    fontWeight: FontWeight.bold,
                    fontFamily: "wendyOne",
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () {
                    onPressContinue?.call();
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "wendyOne",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                  ),
                  onPressed: () {
                    onPressRestart?.call();
                  },
                  child: const Text(
                    'Restart',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "wendyOne"),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    onPressQuit?.call();
                  },
                  child: const Text(
                    'Quit',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "wendyOne"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
