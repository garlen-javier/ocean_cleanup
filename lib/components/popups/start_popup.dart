import 'package:flutter/material.dart';
import 'package:ocean_cleanup/components/popups/tutorials/intoduction_two_popup.dart';
import 'package:ocean_cleanup/constants.dart';
import 'package:ocean_cleanup/levels/level_parameters.dart';
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
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: Color(0xFF6874ca), width: 5),
      ),
      backgroundColor: Colors.white,
      title: Text(
        'Level ${widget.levelIndex}',
        style: TextStyle(
          color: Colors.orange,
          fontSize: SizeConfig.mediumText1,
          fontWeight: FontWeight.bold,
          fontFamily: "wendyOne",
        ),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 225, 226, 243),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Target",
                    style: TextStyle(
                      fontSize: SizeConfig.smallText1,
                      color: Colors.black,
                      fontFamily: 'wendyOne',
                    ),
                  ),
                  Levels.instance.params[widget.levelIndex - 1].trappedAnimals
                              ?.isNotEmpty ??
                          false
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/${Levels.instance.params[widget.levelIndex - 1].trashObjectives[0].trashType == TrashType.bagTrash ? pathBagTrash : Levels.instance.params[widget.levelIndex - 1].trashObjectives[0].trashType == TrashType.cutleries ? pathCutleries : Levels.instance.params[widget.levelIndex - 1].trashObjectives[0].trashType == TrashType.plasticCup ? pathPlasticCup : Levels.instance.params[widget.levelIndex - 1].trashObjectives[0].trashType == TrashType.straw ? pathStraw : Levels.instance.params[widget.levelIndex - 1].trashObjectives[0].trashType == TrashType.styroFoam ? pathStyrofoam : Levels.instance.params[widget.levelIndex - 1].trashObjectives[0].trashType == TrashType.waterBottle ? pathWaterBottle : Levels.instance.params[widget.levelIndex - 1].trashObjectives[0].trashType == TrashType.waterGallon ? pathWaterGallon : "fish_net.png"}",
                                  width: 50,
                                  height: 50,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  Levels.instance.params[widget.levelIndex - 1]
                                      .trashObjectives[0].goal
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: SizeConfig.smallText1,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'wendyOne',
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
                                    fontSize: SizeConfig.smallText1,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'wendyOne',
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                widget.levelIndex != 4
                                    ? Image.asset(
                                        Levels
                                                    .instance
                                                    .params[
                                                        widget.levelIndex - 1]
                                                    .trappedAnimals!
                                                    .entries
                                                    .first
                                                    .key
                                                    .name ==
                                                'seaTurtle'
                                            ? "assets/images/Sad_Turtle_01_1.png"
                                            : Levels
                                                        .instance
                                                        .params[
                                                            widget.levelIndex -
                                                                1]
                                                        .trappedAnimals!
                                                        .entries
                                                        .first
                                                        .key
                                                        .name ==
                                                    'crab'
                                                ? "assets/images/Sad_Crab_01_6.png"
                                                : Levels
                                                            .instance
                                                            .params[widget
                                                                    .levelIndex -
                                                                1]
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
                                      )
                                    : Row(
                                        children: [
                                          Image.asset(
                                            Levels
                                                        .instance
                                                        .params[
                                                            widget.levelIndex -
                                                                1]
                                                        .trappedAnimals!
                                                        .entries
                                                        .first
                                                        .key
                                                        .name ==
                                                    'seaTurtle'
                                                ? "assets/images/Sad_Turtle_01_1.png"
                                                : Levels
                                                            .instance
                                                            .params[widget
                                                                    .levelIndex -
                                                                1]
                                                            .trappedAnimals!
                                                            .entries
                                                            .first
                                                            .key
                                                            .name ==
                                                        'crab'
                                                    ? "assets/images/Sad_Crab_01_6.png"
                                                    : Levels
                                                                .instance
                                                                .params[widget
                                                                        .levelIndex -
                                                                    1]
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
                                          Image.asset(
                                            Levels
                                                        .instance
                                                        .params[
                                                            widget.levelIndex -
                                                                1]
                                                        .trappedAnimals!
                                                        .entries
                                                        .last
                                                        .key
                                                        .name ==
                                                    'seaTurtle'
                                                ? "assets/images/Sad_Turtle_01_1.png"
                                                : Levels
                                                            .instance
                                                            .params[widget
                                                                    .levelIndex -
                                                                1]
                                                            .trappedAnimals!
                                                            .entries
                                                            .last
                                                            .key
                                                            .name ==
                                                        'crab'
                                                    ? "assets/images/Sad_Crab_01_6.png"
                                                    : Levels
                                                                .instance
                                                                .params[widget
                                                                        .levelIndex -
                                                                    1]
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
                                      ),
                                const SizedBox(width: 10),
                                Text(
                                  "Free",
                                  style: TextStyle(
                                    fontSize: SizeConfig.smallText1,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'wendyOne',
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Levels.instance.params[widget.levelIndex - 1]
                                        .trashObjectives.length ==
                                    1
                                ? Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/${Levels.instance.params[widget.levelIndex - 1].trashObjectives[0].trashType == TrashType.bagTrash ? pathBagTrash : Levels.instance.params[widget.levelIndex - 1].trashObjectives[0].trashType == TrashType.cutleries ? pathCutleries : Levels.instance.params[widget.levelIndex - 1].trashObjectives[0].trashType == TrashType.plasticCup ? pathPlasticCup : Levels.instance.params[widget.levelIndex - 1].trashObjectives[0].trashType == TrashType.straw ? pathStraw : Levels.instance.params[widget.levelIndex - 1].trashObjectives[0].trashType == TrashType.styroFoam ? pathStyrofoam : Levels.instance.params[widget.levelIndex - 1].trashObjectives[0].trashType == TrashType.waterBottle ? pathWaterBottle : Levels.instance.params[widget.levelIndex - 1].trashObjectives[0].trashType == TrashType.waterGallon ? pathWaterGallon : "fish_net.png"}",
                                        width: 50,
                                        height: 50,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        Levels
                                            .instance
                                            .params[widget.levelIndex - 1]
                                            .trashObjectives[0]
                                            .goal
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: SizeConfig.smallText1,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'wendyOne',
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: List.generate(
                                      Levels
                                          .instance
                                          .params[widget.levelIndex - 1]
                                          .trashObjectives
                                          .length,
                                      (index) => Column(
                                        children: [
                                          Image.asset(
                                            "assets/images/${Levels.instance.params[widget.levelIndex - 1].trashObjectives[index].trashType == TrashType.bagTrash ? pathBagTrash : Levels.instance.params[widget.levelIndex - 1].trashObjectives[index].trashType == TrashType.cutleries ? pathCutleries : Levels.instance.params[widget.levelIndex - 1].trashObjectives[index].trashType == TrashType.plasticCup ? pathPlasticCup : Levels.instance.params[widget.levelIndex - 1].trashObjectives[index].trashType == TrashType.straw ? pathStraw : Levels.instance.params[widget.levelIndex - 1].trashObjectives[index].trashType == TrashType.styroFoam ? pathStyrofoam : Levels.instance.params[widget.levelIndex - 1].trashObjectives[index].trashType == TrashType.waterBottle ? pathWaterBottle : pathWaterGallon}",
                                            width: 50,
                                            height: 50,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            Levels
                                                .instance
                                                .params[widget.levelIndex - 1]
                                                .trashObjectives[index]
                                                .goal
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: SizeConfig.smallText1,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'wendyOne',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                    fontSize: SizeConfig.smallText1,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'wendyOne',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                ],
              ),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Back',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "wendyOne",
              fontSize: SizeConfig.smallText1,
            ),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          onPressed: () async {
            bool tuto2 = SaveUtils.instance.getTutorialStatus("tuto2");
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
                    builder: (BuildContext context) => const GameViewScreen(),
                    settings: RouteSettings(
                      arguments: widget.levelIndex - 1,
                    ),
                  ),
                  ModalRoute.withName('/home'),
                );
              }
            }
          },
          child: Text(
            'Play',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "wendyOne",
              fontSize: SizeConfig.smallText1,
            ),
          ),
        ),
      ],
    );
  }
}
