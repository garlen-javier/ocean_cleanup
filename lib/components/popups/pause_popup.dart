import 'package:flutter/material.dart';
import 'package:ocean_cleanup/bloc/game/game_bloc.dart';
import 'package:ocean_cleanup/bloc/game/game_event.dart';
import 'package:ocean_cleanup/screens/levels/levels_screen.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

void showPausePopup(BuildContext context, GameBloc gameBloc) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
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
                    Navigator.of(context).pop();
                    gameBloc.add(const GameResume());
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
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    gameBloc.add(const GameQuit());
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LevelsScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Quit',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "wendyOne",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
