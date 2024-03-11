import 'package:flutter/material.dart';
import 'package:ocean_cleanup/components/popups/tutorials/intoduction_two_popup.dart';
import 'package:ocean_cleanup/levels/levels.dart';
import 'package:ocean_cleanup/screens/game/game_view_screen.dart';
import 'package:ocean_cleanup/utils/config_size.dart';
import 'package:ocean_cleanup/utils/save_utils.dart';

class StartPopup extends StatefulWidget {
  final int levelIndex;
  const StartPopup({super.key, required this.levelIndex});

  @override
  State<StartPopup> createState() => _StartPopupState();
}

class _StartPopupState extends State<StartPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: Color(0xFF6874ca), width: 5),
      ),
      backgroundColor: Colors.white,
      child: SizedBox(
        width: SizeConfig.screenWidth / 2,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Level ${widget.levelIndex}',
                style: TextStyle(
                  fontSize: SizeConfig.mediumText1,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'wendyOne',
                ),
              ),
              Text(
                'Target',
                style: TextStyle(
                  fontSize: SizeConfig.mediumText1,
                  color: const Color(0xFF6874ca),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'comicNeue',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/trashes/water_gallon.png',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        Levels.instance.params[widget.levelIndex - 1]
                            .trashObjectives[0].goal
                            .toString(),
                        style: TextStyle(
                          fontSize: SizeConfig.mediumText1,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'comicNeue',
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/stopwatch.png',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        Levels.instance.params[widget.levelIndex - 1]
                            .trashObjectives[0].timeLimit
                            .toString(),
                        style: TextStyle(
                          fontSize: SizeConfig.mediumText1,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'comicNeue',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Levels.instance.params[widget.levelIndex - 1].trappedAnimals
                          ?.isNotEmpty ??
                      false
                  ? widget.levelIndex != 4
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Save the",
                              style: TextStyle(
                                fontSize: SizeConfig.mediumText1,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'comicNeue',
                              ),
                            ),
                            Image.asset(
                              Levels
                                          .instance
                                          .params[widget.levelIndex - 1]
                                          .trappedAnimals!
                                          .entries
                                          .first
                                          .key
                                          .name ==
                                      'seaTurtle'
                                  ? "assets/images/Sad_Turtle_01_1.png"
                                  : Levels
                                              .instance
                                              .params[widget.levelIndex - 1]
                                              .trappedAnimals!
                                              .entries
                                              .first
                                              .key
                                              .name ==
                                          'crab'
                                      ? "assets/images/Sad_Crab_01_6.png"
                                      : Levels
                                                  .instance
                                                  .params[widget.levelIndex - 1]
                                                  .trappedAnimals!
                                                  .entries
                                                  .first
                                                  .key
                                                  .name ==
                                              'dolphin'
                                          ? "assets/images/Dolphin_01_1.png"
                                          : "assets/images/whale_sprite.png",
                              width: 50,
                              height: 50,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Save the",
                              style: TextStyle(
                                fontSize: SizeConfig.mediumText1,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'comicNeue',
                              ),
                            ),
                            Image.asset(
                              Levels
                                          .instance
                                          .params[widget.levelIndex - 1]
                                          .trappedAnimals!
                                          .entries
                                          .first
                                          .key
                                          .name ==
                                      'seaTurtle'
                                  ? "assets/images/Sad_Turtle_01_1.png"
                                  : Levels
                                              .instance
                                              .params[widget.levelIndex - 1]
                                              .trappedAnimals!
                                              .entries
                                              .first
                                              .key
                                              .name ==
                                          'crab'
                                      ? "assets/images/Sad_Crab_01_6.png"
                                      : Levels
                                                  .instance
                                                  .params[widget.levelIndex - 1]
                                                  .trappedAnimals!
                                                  .entries
                                                  .first
                                                  .key
                                                  .name ==
                                              'dolphin'
                                          ? "assets/images/Dolphin_01_1.png"
                                          : "assets/images/whale_sprite.png",
                              width: 50,
                              height: 50,
                            ),
                            Text(
                              "and",
                              style: TextStyle(
                                fontSize: SizeConfig.mediumText1,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'comicNeue',
                              ),
                            ),
                            Image.asset(
                              Levels
                                          .instance
                                          .params[widget.levelIndex - 1]
                                          .trappedAnimals!
                                          .entries
                                          .last
                                          .key
                                          .name ==
                                      'seaTurtle'
                                  ? "assets/images/Sad_Turtle_01_1.png"
                                  : Levels
                                              .instance
                                              .params[widget.levelIndex - 1]
                                              .trappedAnimals!
                                              .entries
                                              .last
                                              .key
                                              .name ==
                                          'crab'
                                      ? "assets/images/Sad_Crab_01_6.png"
                                      : Levels
                                                  .instance
                                                  .params[widget.levelIndex - 1]
                                                  .trappedAnimals!
                                                  .entries
                                                  .last
                                                  .key
                                                  .name ==
                                              'dolphin'
                                          ? "assets/images/Dolphin_01_1.png"
                                          : "assets/images/whale_sprite.png",
                              width: 50,
                              height: 50,
                            ),
                          ],
                        )
                  : Container(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "wendyOne",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange),
                      ),
                      onPressed: () async {
                        bool tuto2 =
                            await SaveUtils.instance.getTutorialStatus("tuto2");
                        if (!tuto2) {
                          if (mounted) {
                            showIntroTwoPopup(context, widget.levelIndex);
                          }

                          SaveUtils.instance.saveTutorialStatus("tuto2", true);
                        } else {
                          if (mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>  const GameViewScreen(
                                ),
                                settings: RouteSettings(
                                  arguments: widget.levelIndex - 1,
                                ),
                              ),
                              ModalRoute.withName('/home'),
                            );
                            
                          }
                        }
                      },
                      child: const Text(
                        'Play',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "wendyOne",
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
