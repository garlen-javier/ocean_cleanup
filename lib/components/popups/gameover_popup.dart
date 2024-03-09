import 'package:flutter/material.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

void showGameOverPopup(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(color: Colors.yellow, width: 5),
        ),
        backgroundColor: const Color.fromARGB(255, 181, 188, 239),
        child: SizedBox(
          width: SizeConfig.screenWidth / 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star_border_rounded,
                        color: Colors.yellow, size: 50.0),
                    Icon(Icons.star_border_rounded,
                        color: Colors.yellow, size: 80.0),
                    Icon(Icons.star_border_rounded,
                        color: Colors.yellow, size: 50.0),
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
                              "25",
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
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: SizeConfig.screenWidth / 2.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.white,
                                size: SizeConfig.largeText1 + 10,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Back",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.smallText1,
                              fontWeight: FontWeight.bold,
                              fontFamily: "wendyOne",
                            ),
                          ),
                        ],
                      ),
                      Column(
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
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Restart",
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
              ],
            ),
          ),
        ),
      );
    },
  );
}
