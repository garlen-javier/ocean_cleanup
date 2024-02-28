import 'package:flutter/material.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

void showGameOverPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          width: SizeConfig.screenWidth / 3,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                'assets/images/game_over.png',
                width: SizeConfig.screenWidth / 2,
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/requin.png',
                        width: 40.0,
                        height: 50.0,
                      ),
                      Text(
                        '5 animals',
                        style: TextStyle(
                          fontSize: SizeConfig.smallText1,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/plastic.png',
                        width: 40.0,
                        height: 50.0,
                      ),
                      Text(
                        '25 plastic',
                        style: TextStyle(
                          fontSize: SizeConfig.smallText1,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child: Text(
                      'Home',
                      style: TextStyle(
                        fontSize: SizeConfig.smallText1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orangeAccent),
                    ),
                    child: Text(
                      'Replay',
                      style: TextStyle(
                        fontSize: SizeConfig.smallText1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
