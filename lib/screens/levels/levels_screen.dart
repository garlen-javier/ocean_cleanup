import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:ocean_cleanup/bloc/auth/auth_bloc.dart';
import 'package:ocean_cleanup/components/popups/settings_popup.dart';
import 'package:ocean_cleanup/components/popups/start_popup.dart';
import 'package:ocean_cleanup/screens/leaderboard/leaderboard_screen.dart';
import 'package:ocean_cleanup/utils/config_size.dart';
import 'package:ocean_cleanup/utils/save_utils.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({super.key});

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

final formKey = GlobalKey<FormState>();

class _LevelsScreenState extends State<LevelsScreen> {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    print('Level : ${SaveUtils.instance.getUnlockedLevel}');
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton.large(
          elevation: 0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LeaderboardScreen(),
              ),
            );
          },
          backgroundColor: Colors.transparent,
          child: Lottie.asset(
            "assets/animations/leaderboard.json",
            repeat: false,
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Select Level',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange,
              fontSize: 30,
              fontFamily: 'wendyOne',
            ),
          ),
          foregroundColor: const Color(0xFF6874ca),
          actions: [
            IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SettingsPopup(
                      isLoggedIn: authBloc.isLoggedIn,
                    );
                  }),
              icon: const Icon(
                Icons.settings,
                color: Color(0xFF6874ca),
                size: 30,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: SizedBox(
              width: SizeConfig.screenWidth / 1.5,
              height: SizeConfig.screenHeight / 1.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(3, (index) {
                      if (index <= SaveUtils.instance.getUnlockedLevel) {
                        return GestureDetector(
                            child: Image.asset(
                                'assets/images/levels/Level${index + 1}.png'),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StartPopup(
                                    levelIndex: index + 1,
                                  );
                                },
                              );
                            });
                      } else {
                        return Image.asset(
                            'assets/images/levels/Unlocked_Level.png');
                      }
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      2,
                      (index) {
                        if (index + 3 <= SaveUtils.instance.getUnlockedLevel) {
                          return GestureDetector(
                            child: Image.asset(
                                'assets/images/levels/Level${index + 4}.png'),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StartPopup(
                                    levelIndex: index + 4,
                                  );
                                },
                              );
                            },
                          );
                        } else {
                          return Image.asset(
                              'assets/images/levels/Unlocked_Level.png');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
