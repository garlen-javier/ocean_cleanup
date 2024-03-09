import 'package:flutter/material.dart';
import 'package:ocean_cleanup/utils/config_size.dart';
import 'package:ocean_cleanup/utils/save_utils.dart';

void showIntroOnePopup(BuildContext context) {
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
                  width: SizeConfig.screenWidth / 1.5,
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
                            'The ocean is polluted, the animals are trapped and \n the octopus queen is angry. ',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'comicNeue',
                        ),
                      ),
                      const TextSpan(
                        text:
                            'Your mission: to \n retrieve and gather scattered debris that plagues',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'comicNeue',
                          color: Colors.black,
                        ),
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Image.asset(
                            'assets/images/fish_net.png',
                            height: SizeConfig.mediumText1,
                          ),
                        ),
                      ),
                      const TextSpan(
                        text: '\n these waters.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'comicNeue',
                          color: Colors.black,
                        ),
                      ),
                      const TextSpan(
                        text:
                            'Your success hinges on reaching a \n designated quota of waste collected, ensuring the \n revival of the ocean\'s delicate balance. Be careful \n not to bump into sharks',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'comicNeue',
                        ),
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Image.asset(
                            'assets/images/solo_shark.png',
                            height: SizeConfig.mediumText1,
                          ),
                        ),
                      ),
                      const TextSpan(
                        text: 'Good luck brave diver!',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontFamily: 'comicNeue',
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    SaveUtils.instance.saveTutorialStatus("tuto1", true);
                  } ,
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
