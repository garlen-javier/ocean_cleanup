import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocean_cleanup/bloc/auth/auth_bloc.dart';
import 'package:ocean_cleanup/bloc/game_stats/sound_state.dart';
import 'package:ocean_cleanup/components/popups/auth_popup.dart';
import 'package:ocean_cleanup/components/popups/reset_popup.dart';
import 'package:ocean_cleanup/models/user_model.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

class SettingsPopup extends StatelessWidget {
  final bool isLoggedIn;
  const SettingsPopup({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final SoundStateBloc bloc = SoundStateBloc();

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: Color(0xFF6874ca), width: 5),
      ),
      backgroundColor: Colors.white,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: const Color(0xFF6874ca),
              size: SizeConfig.mediumText1,
            ),
          ),
          const Spacer(),
          Text(
            'Settings',
            style: TextStyle(
              color: Colors.orange,
              fontSize: SizeConfig.mediumText1,
              fontWeight: FontWeight.bold,
              fontFamily: "wendyOne",
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            isLoggedIn
                ? FutureBuilder<UserModel?>(
                    future: authBloc.getUserData(authBloc.state.id!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        final user = snapshot.data!;
                        return Container(
                          height: SizeConfig.screenHeight / 8,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 225, 226, 243),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_rounded,
                                color: const Color(0xFF6874ca),
                                size: SizeConfig.mediumText1,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  user.username,
                                  style: TextStyle(
                                    fontSize: SizeConfig.smallText1,
                                    color: Colors.black,
                                    fontFamily: 'wendyOne',
                                  ),
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF6874ca),
                                  ),
                                ),
                                onPressed: () {
                                  authBloc.signOut(context);
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Logout',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "wendyOne",
                                    fontSize: SizeConfig.smallText1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Text('Error: ${snapshot.error}');
                      }
                    })
                : Container(
                    height: SizeConfig.screenHeight / 8,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 225, 226, 243),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_rounded,
                          color: const Color(0xFF6874ca),
                          size: SizeConfig.mediumText1,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Guest",
                            style: TextStyle(
                              fontSize: SizeConfig.smallText1,
                              color: Colors.black,
                              fontFamily: 'wendyOne',
                            ),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF6874ca),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AuthPopup();
                                });
                          },
                          child: Text(
                            'Login / Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "wendyOne",
                              fontSize: SizeConfig.smallText1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(height: 10),
            Container(
              height: SizeConfig.screenHeight / 8,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 225, 226, 243),
              ),
              child: StreamBuilder<bool>(
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
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Music",
                            style: TextStyle(
                              fontSize: SizeConfig.smallText1,
                              color: Colors.black,
                              fontFamily: 'wendyOne',
                            ),
                          ),
                        ),
                        const Spacer(),
                        Switch(
                          value: isMusicOn,
                          activeColor: const Color(0xFF6874ca),
                          onChanged: (bool value) {
                            bloc.toggleMusic();
                          },
                        ),
                      ],
                    );
                  }),
            ),
            const SizedBox(height: 10),
            Container(
              height: SizeConfig.screenHeight / 8,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 225, 226, 243),
              ),
              child: StreamBuilder<bool>(
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
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Sound",
                            style: TextStyle(
                              fontSize: SizeConfig.smallText1,
                              color: Colors.black,
                              fontFamily: 'wendyOne',
                            ),
                          ),
                        ),
                        const Spacer(),
                        Switch(
                          value: isSoundOn,
                          activeColor: const Color(0xFF6874ca),
                          onChanged: (bool value) {
                            bloc.toggleSound();
                          },
                        ),
                      ],
                    );
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: SizeConfig.screenHeight / 8,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 225, 226, 243),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.settings_backup_restore_rounded,
                    color: const Color(0xFF6874ca),
                    size: SizeConfig.mediumText1,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Rest Game",
                      style: TextStyle(
                        fontSize: SizeConfig.smallText1,
                        color: Colors.black,
                        fontFamily: 'wendyOne',
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xFF6874ca),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const ResetPopup();
                          });
                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "wendyOne",
                        fontSize: SizeConfig.smallText1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
