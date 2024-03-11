import 'package:flutter/material.dart';
import 'package:ocean_cleanup/bloc/game/game_bloc.dart';
import 'package:ocean_cleanup/bloc/game/game_event.dart';
import 'package:ocean_cleanup/bloc/game_stats/sound_state.dart';
import 'package:ocean_cleanup/core/audio_manager.dart';
import 'package:ocean_cleanup/screens/levels/levels_screen.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

Dialog showPausePopup(BuildContext context,
    {VoidCallback? onPressContinue,
    VoidCallback? onPressRestart,
    VoidCallback? onPressQuit}) {
  final SoundStateBloc bloc = SoundStateBloc();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder<bool>(
                  stream: bloc.soundState,
                  initialData: bloc.isSoundOn,
                  builder: (context, soundSnapshot) {
                    bool isSoundOn = soundSnapshot.data ?? false;
                    return Row(
                      children: [
                        Icon(
                          Icons.volume_up_rounded,
                          color: Colors.white,
                          size: SizeConfig.mediumText1,
                        ),
                        Text(
                          "Sounds",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.smallText1,
                            fontFamily: "wendyOne",
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            bloc.toggleSound();
                            AudioManager.instance.muteSfx(!bloc.isSoundOn);
                          },
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: isSoundOn
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: SizeConfig.smallText1,
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: SizeConfig.smallText1,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<bool>(
                  stream: bloc.musicState,
                  initialData: bloc.isMusicOn,
                  builder: (context, musicSnapshot) {
                    bool isMusicOn = musicSnapshot.data ?? false;
                    return Row(
                      children: [
                        Icon(
                          Icons.music_note_rounded,
                          color: Colors.white,
                          size: SizeConfig.mediumText1,
                        ),
                        Text(
                          "Music",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.smallText1,
                            fontFamily: "wendyOne",
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            bloc.toggleMusic();
                            AudioManager.instance.muteBgm(!bloc.isMusicOn);
                          },
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: isMusicOn
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: SizeConfig.smallText1,
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: SizeConfig.smallText1,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
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
