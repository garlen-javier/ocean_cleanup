import 'package:flutter/material.dart';
import '../../../screens/game/game_view_screen.dart';
import '../../../utils/config_size.dart';

class TutorialAnimalRescue extends StatelessWidget {
   int levelIndex;
   TutorialAnimalRescue({required this.levelIndex,super.key});

  @override
  Widget build(BuildContext context) {

    return Material(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                isAntiAlias: true,
                image: AssetImage(
                    'assets/images/background.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: SingleChildScrollView(
              child: SizedBox(
                height: constraints.maxHeight,
                child: Column(
                  children: [
                    Flexible(child: SingleChildScrollView(child: _timerCounter(context, constraints))),
                    Expanded(
                      flex: 2,
                        child: _popUpBox(context,constraints)),
                  ],
                ),
              ),
            ));
      }),
    );
  }

Widget _timerCounter(BuildContext context, BoxConstraints constraints)
{
  return Column(
    children: [
      Text("12:00",style: TextStyle(fontWeight: FontWeight.bold, color: const Color(0xFF0B1480), fontSize: SizeConfig.smallText2),),
      Padding(
        padding: EdgeInsets.only(right: constraints.maxWidth * 0.04),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
                child: _trashCount()),
            const Spacer(flex: 1,),
            Flexible(
              flex: 1,
                child: Stack(
                  children: [
                    Image.asset('assets/images/tutorials/animal_frame_green.png'),
                    Transform.translate(
                      offset: const Offset(14,14),
                        child: Image.asset('assets/images/Sad_Crab_01_6.png')),
                  ],
                )),
          ],
        ),
      ),
    ],
  );

}

Widget _trashCount()
{
  return  Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: SizeConfig.smallText1,
          ),
          children: [
            WidgetSpan(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Image.asset(
                  'assets/images/fish_net.png',
                  height: SizeConfig.mediumText1,
                ),
              ),
            ),
            const TextSpan(text:
            '0/20',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: const Color(0xFF0B1480),
              ),
            ),
          ],
        ),
      ),
      SizedBox(width: 10,),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: SizeConfig.smallText1,
          ),
          children: [
            WidgetSpan(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Image.asset(
                  'assets/images/trashes/plastic_cup.png',
                  height: SizeConfig.mediumText1,
                ),
              ),
            ),
            const TextSpan(text:
            '0/6',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: const Color(0xFF0B1480),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}


Widget _popUpBox(BuildContext context, BoxConstraints constraints) {
  return Padding(
    padding: EdgeInsets.only(
      //  bottom: constraints.maxHeight * 0.1,
        left: constraints.maxWidth * 0.15,
        right: constraints.maxWidth * 0.15 ),
    child: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/tutorials/animal_rescue_box.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 38,left: 8,right: 8,bottom: 18),
        child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/tutorials/new_mission_title.png'),
                    ),
                    const SizedBox(height: 4,),
                    Padding(
                      padding: const EdgeInsets.only(top: 8,left: 12,right: 12,bottom: 8),
                      child: Text(
                        "Set free the animal entangled in waste by gathering the amount of specific trash that is set on the top. Keep an eye on the timer attached to the animal; you must collect the trash required before the time runs out.",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'comicNeue',
                          color: Colors.black,
                          fontSize: SizeConfig.smallText1,
                          letterSpacing: 1.8,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/tutorials/tutorial_crab.png'),
                        Padding(
                          padding: const EdgeInsets.only(right: 55),
                          child: IconButton(
                             style: IconButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                          ),
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: Image.asset('assets/images/tutorials/ready_button.png'),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  const GameViewScreen(),
                                  settings: RouteSettings(
                                    arguments: levelIndex,
                                  ),
                                ),
                                ModalRoute.withName('/home'),
                              );
                            },
                          ),
                        ),
                      ],
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