import 'package:flutter/material.dart';
import 'package:ocean_cleanup/components/popups/tutorials/introduction_two_popup.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

class IntroOnePopup extends StatelessWidget {
  const IntroOnePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: Container(
          width: SizeConfig.screenWidth / 1.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: const Color(0xFF6874ca),
              width: 5,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
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
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const IntroTwoPopup(),
                      ),
                    );
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
      ),
    ));
  }
}
