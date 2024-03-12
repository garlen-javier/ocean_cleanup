import 'package:flutter/material.dart';
import 'package:ocean_cleanup/screens/game/game_view_screen.dart';
import 'package:ocean_cleanup/utils/config_size.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../../utils/utils.dart';
import 'introduction_one_popup.dart';

void showTutoPopup(BuildContext context, int levelIndex) {
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
                        'assets/images/tutorials/Instructions_title.png',
                        width: SizeConfig.screenWidth / 2.5,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                !kIsWeb
                    ? Row(
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
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/tutorials/keyboard_button.png',
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: SizeConfig.smallText1,
                                letterSpacing: 1.8,
                              ),
                              children: [
                                const TextSpan(
                                  text:
                                      'Use the keyboard to move \n (W, A, S, D) around in \n the ocean. When you come near \n any waste click the space bar to collect it.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'comicNeue',
                                  ),
                                ),
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    child: Image.asset(
                                      'assets/images/fish_net.png',
                                      height: SizeConfig.mediumText1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,Utils.nextPage(const IntroOnePopup()));
                  },
                  child: Image.asset(
                    'assets/images/Button_Continue.png',
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


