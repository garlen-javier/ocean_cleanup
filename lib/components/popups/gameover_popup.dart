import 'package:flutter/material.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

class GameoverPopup extends StatelessWidget {
  final int level;
  final int score;
  final void Function()? onPressBack;
  final void Function()? onPressRestart;
  const GameoverPopup(
      {super.key,
      required this.level,
      required this.score,
      this.onPressBack,
      this.onPressRestart});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: Color(0xFF6874ca), width: 5),
      ),
      backgroundColor: Colors.white,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star_border_rounded,
                color: Colors.yellow,
                size: SizeConfig.largeText1 + 20,
              ),
              Icon(
                Icons.star_border_rounded,
                color: Colors.yellow,
                size: SizeConfig.largeText1 + 40,
              ),
              Icon(
                Icons.star_border_rounded,
                color: Colors.yellow,
                size: SizeConfig.largeText1 + 20,
              ),
            ],
          ),
          Text(
            "You Failed !",
            style: TextStyle(
              color: Colors.red,
              fontSize: SizeConfig.mediumText1,
              fontWeight: FontWeight.bold,
              fontFamily: "wendyOne",
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xFF6874ca),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Target: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.smallText1,
                            fontWeight: FontWeight.bold,
                            fontFamily: "wendyOne",
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Center(
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: SizeConfig.mediumText1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Score: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.smallText1,
                            fontWeight: FontWeight.bold,
                            fontFamily: "wendyOne",
                          ),
                        ),
                        Text(
                          score.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.smallText1,
                            fontWeight: FontWeight.bold,
                            fontFamily: "wendyOne",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
          onPressed: () {
            onPressBack?.call();
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
            backgroundColor: MaterialStateProperty.all(Colors.orange),
          ),
          onPressed: () {
            onPressRestart?.call();
          },
          child: Text(
            'Restart',
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
