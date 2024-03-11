import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:ocean_cleanup/bloc/auth/auth_bloc.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

Dialog showVictoryPopup(BuildContext context, int level, int score,
    {VoidCallback? onPressRetry, VoidCallback? onPressNext}) {
  final authBloc = BlocProvider.of<AuthBloc>(context);
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
      side: const BorderSide(color: Colors.yellow, width: 5),
    ),
    backgroundColor: const Color.fromARGB(255, 181, 188, 239),
    child: SizedBox(
      width: SizeConfig.screenWidth / 2,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.normalpadding,
              right: SizeConfig.normalpadding,
              bottom: SizeConfig.normalpadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
                Container(
                  width: SizeConfig.screenWidth / 2.5,
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
                SizedBox(
                  height: SizeConfig.blockSizeVertical,
                ),
                SizedBox(
                  width: SizeConfig.screenWidth / 2.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          onPressRetry?.call();
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.refresh_rounded,
                                  color: Colors.white,
                                  size: SizeConfig.largeText1 + 10,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical,
                            ),
                            Text(
                              "Retry",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.smallText1,
                                fontWeight: FontWeight.bold,
                                fontFamily: "wendyOne",
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (authBloc.isLoggedIn) {
                            authBloc
                                .updateScore(score)
                                .then((value) => onPressNext?.call());
                          } else {
                            onPressNext?.call();
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_right_alt_rounded,
                                  color: Colors.white,
                                  size: SizeConfig.largeText1 + 10,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical,
                            ),
                            Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.smallText1,
                                fontWeight: FontWeight.bold,
                                fontFamily: "wendyOne",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Lottie.asset(
            'assets/animations/confetti.json',
            width: SizeConfig.screenWidth / 2,
            height: SizeConfig.screenHeight / 4,
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
            repeat: false,
          ),
        ],
      ),
    ),
  );
}
