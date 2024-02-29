import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:ocean_cleanup/bloc/bloc_parameters.dart';
import 'package:ocean_cleanup/bloc/joystick_movement/joystick_movement_bloc.dart';
import 'package:ocean_cleanup/bloc/player_stats/player_stats_bloc.dart';
import 'package:ocean_cleanup/components/into%20game/start_button.dart';
import 'package:ocean_cleanup/scenes/game_scene.dart';
import 'package:ocean_cleanup/screens/auth/auth_screen.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

class IntroGameScreen extends StatefulWidget {
  const IntroGameScreen({super.key});

  @override
  State<IntroGameScreen> createState() => _IntroGameScreenState();
}

class _IntroGameScreenState extends State<IntroGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: MediaQuery.of(context).size.width / 3,
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Lottie.asset('assets/animations/bubbles.json',
                        width: 150.0, height: SizeConfig.screenHeight / 6),
                    StartButton(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameWidget(
                            game: GameScene(
                              blocParameters: BlocParameters(
                                joystickMovementBloc:
                                    context.read<JoystickMovementBloc>(),
                                playerStatsBloc:
                                    context.read<PlayerStatsBloc>(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: SizeConfig.screenWidth / 2.5,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF0097B2),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFF0097B2),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
