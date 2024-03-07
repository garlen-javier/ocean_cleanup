import 'package:expandable_menu/expandable_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocean_cleanup/bloc/auth/auth_bloc.dart';
import 'package:ocean_cleanup/bloc/game_stats/sound_state.dart';
import 'package:ocean_cleanup/components/popups/account_popup.dart';
import 'package:ocean_cleanup/screens/auth/auth_screen.dart';
import 'package:ocean_cleanup/screens/levels/levels_screen.dart';
import 'package:ocean_cleanup/utils/config_size.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroGameScreen extends StatefulWidget {
  const IntroGameScreen({super.key});

  @override
  State<IntroGameScreen> createState() => _IntroGameScreenState();
}

class _IntroGameScreenState extends State<IntroGameScreen> {
  final SoundStateBloc bloc = SoundStateBloc();

  
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return  Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            SizedBox(
              height: double.infinity,
              width: SizeConfig.screenWidth / 4,
              child: ExpandableMenu(
                backgroundColor: Colors.transparent,
                height: 70,
                width: 70,
                iconColor: const Color(0xFF6874ca),
                itemContainerColor: Colors.transparent,
                items: [
                  IconButton(
                    onPressed: () => showAccount(
                      context,
                      authBloc.isLoggedIn,
                    ),
                    icon: const Icon(
                      Icons.person_2_rounded,
                      color: Color(0xFF6874ca),
                      size: 30,
                    ),
                  ),
                  StreamBuilder<bool>(
                      stream: bloc.soundState,
                      initialData: bloc.isSoundOn,
                      builder: (context, snapshot) {
                        return GestureDetector(
                          onTap: () {
                            bloc.toggleSound();
                          },
                          child: Image.asset(
                            snapshot.data!
                                ? 'assets/images/Sound_On1x.png'
                                : 'assets/images/Sound_Off1x.png',
                            width: 50,
                          ),
                        );
                      })
                ],
              ),
            ),
          ],
        ),
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 390),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    "assets/images/Game_Title4x 1.png",
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LevelsScreen(
                          username: '',
                        ),
                      ),
                    ),
                    child: Image.asset('assets/images/Play_Button4x 1.png'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
