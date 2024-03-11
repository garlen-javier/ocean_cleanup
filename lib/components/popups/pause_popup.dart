import 'package:flutter/material.dart';
import 'package:ocean_cleanup/bloc/game_stats/sound_state.dart';
import 'package:ocean_cleanup/core/audio_manager.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

class PausePopup extends StatelessWidget {
  final void Function()? onPressContinue;
  final void Function()? onPressRestart;
  final void Function()? onPressQuit;
  const PausePopup(
      {super.key, this.onPressContinue, this.onPressRestart, this.onPressQuit});

  @override
  Widget build(BuildContext context) {
    final SoundStateBloc bloc = SoundStateBloc();
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: Color(0xFF6874ca), width: 5),
      ),
      backgroundColor: Colors.white,
      title: Text(
        'Pause',
        style: TextStyle(
          color: Colors.orange,
          fontSize: SizeConfig.mediumText1,
          fontWeight: FontWeight.bold,
          fontFamily: "wendyOne",
        ),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
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
                            color: const Color(0xFF6874ca),
                            size: SizeConfig.mediumText1,
                          ),
                          Text(
                            "Sounds",
                            style: TextStyle(
                              color: Colors.black,
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
                            color: const Color(0xFF6874ca),
                            size: SizeConfig.mediumText1,
                          ),
                          Text(
                            "Music",
                            style: TextStyle(
                              color: Colors.black,
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
               SizedBox(
                height: SizeConfig.blockSizeVertical,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                onPressed: () {
                  onPressContinue?.call();
                },
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "wendyOne",
                    fontSize: SizeConfig.smallText1,
                  ),
                ),
              ),
               SizedBox(
                height: SizeConfig.blockSizeVertical,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                ),
                onPressed: () {
                  onPressRestart?.call();
                },
                child: Text(
                  'Restart',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "wendyOne",
                    fontSize: SizeConfig.smallText1,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  onPressQuit?.call();
                },
                child: Text(
                  'Quit',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "wendyOne",
                    fontSize: SizeConfig.smallText1,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
