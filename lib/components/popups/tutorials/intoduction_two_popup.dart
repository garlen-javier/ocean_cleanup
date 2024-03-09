import 'package:flutter/material.dart';
import 'package:ocean_cleanup/screens/game/game_view_screen.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

void showIntroTwoPopup(BuildContext context, int levelIndex) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(color: Color(0xFF6874ca), width: 5),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.arrow_back,
                              color: Color(0xFF6874ca),
                            ),
                            Text(
                              'Back',
                              style: TextStyle(
                                fontSize: SizeConfig.smallText1,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'wendyOne',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Image.asset(
                        'assets/images/tutorials/Instructions title.png',
                        width: SizeConfig.screenWidth / 2.5,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/tutorials/Joystick.png',
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: SizeConfig.smallText1,
                              letterSpacing: 1.8,
                            ),
                            children: const [
                              TextSpan(
                                text: 'Use your finger to ',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontFamily: 'comicNeue',
                                ),
                              ),
                              TextSpan(
                                text: 'move \n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'comicNeue',
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: 'around with the joystick.',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontFamily: 'comicNeue',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/tutorials/Knob.png',
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: SizeConfig.smallText1,
                              letterSpacing: 1.8,
                            ),
                            children: const [
                              TextSpan(
                                text: 'To ',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontFamily: 'comicNeue',
                                ),
                              ),
                              TextSpan(
                                text: 'collect ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'comicNeue',
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'waste, press \n the knob located on the left \n corner of the screen.',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontFamily: 'comicNeue',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameViewScreen(
                          levelIndex: levelIndex - 1,
                        ),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/images/tutorials/Ready button.png',
                    width: SizeConfig.screenWidth / 2.5,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
