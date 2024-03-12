import 'package:flutter/material.dart';
import 'package:ocean_cleanup/constants.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

class VictoryPopup extends StatelessWidget {
  final int levelIndex;
  final int score;
  final void Function()? onPressRetry;
  final void Function()? onPressNext;
  final void Function()? onPressBack;
  const VictoryPopup({
    super.key,
    required this.levelIndex,
    required this.score,
    this.onPressRetry,
    this.onPressNext,
    this.onPressBack,
  });

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
                Icons.star_rate_rounded,
                color: Colors.yellow,
                size: SizeConfig.largeText1 + 20,
              ),
              Icon(
                Icons.star_rate_rounded,
                color: Colors.yellow,
                size: SizeConfig.largeText1 + 40,
              ),
              Icon(
                Icons.star_rate_rounded,
                color: Colors.yellow,
                size: SizeConfig.largeText1 + 20,
              ),
            ],
          ),
          Text(
            "COMPLETED !",
            style: TextStyle(
              color: Colors.green,
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
                              Icons.check,
                              color: Colors.green,
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
            backgroundColor: MaterialStateProperty.all(Colors.orange),
          ),
          onPressed: () {
            onPressRetry?.call();
          },
          child: Text(
            'Retry',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "wendyOne",
              fontSize: SizeConfig.smallText1,
            ),
          ),
        ),
        (levelIndex < maxStageLevel - 1)
            ? _nextButton()
            : _backButton(),
      ],
    );
  }

  Widget _nextButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
      ),
      onPressed: () {
        onPressNext?.call();
      },
      child: Text(
        'Next',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: "wendyOne",
          fontSize: SizeConfig.smallText1,
        ),
      ),
    );
  }

  Widget _backButton() {
    return ElevatedButton(
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
    );
  }
}
