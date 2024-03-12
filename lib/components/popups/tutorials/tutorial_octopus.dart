import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../screens/game/game_view_screen.dart';
import '../../../utils/config_size.dart';

class TutorialOctopus extends StatelessWidget {
  int levelIndex;
  TutorialOctopus({required this.levelIndex,super.key});

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
                        'assets/images/background.png'), // Replace 'background_image.jpg' with your image file
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
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: _popUpBox(context,constraints)),
                                  Flexible(
                                    flex: 0,
                                    child: Image.asset(
                                      'assets/images/tutorials/full_meter.png',
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }

  Widget _timerCounter(BuildContext context, BoxConstraints constraints)
  {
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 16),
      child: Column(
        children: [
          Text("12:00",style: TextStyle(fontWeight: FontWeight.bold, color: const Color(0xFF0B1480), fontSize: SizeConfig.smallText2),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _trashCount(),
            ],
          ),
        ],
      ),
    );

  }

  Widget _trashCount()
  {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
          right: constraints.maxWidth * 0.1),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/tutorials/octopus_mission_box.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16,left: 8,right: 8,bottom: 18),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/tutorials/octo_mission_title.png'),
                  ),
                  const SizedBox(height: 4,),
                  Padding(
                    padding: const EdgeInsets.only(top: 8,left: 12,right: 12,bottom: 8),
                    child: Text(
                      "The Octopus Queen is enraged by the pollution in her ocean realm. Master the art of recycling by gathering similar pieces of trash within the allotted time to reduce her anger meter. Should you fail, brace yourself for her formidable wrath!!",
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
                      IconButton(
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