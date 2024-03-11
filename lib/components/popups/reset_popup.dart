import 'package:flutter/material.dart';
import 'package:ocean_cleanup/utils/config_size.dart';
import 'package:ocean_cleanup/utils/save_utils.dart';

class ResetPopup extends StatelessWidget {
  const ResetPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: Color(0xFF6874ca), width: 5),
      ),
      backgroundColor: Colors.white,
      title: Text(
        'Reset Game',
        style: TextStyle(
          color: Colors.orange,
          fontSize: SizeConfig.mediumText1,
          fontWeight: FontWeight.bold,
          fontFamily: "wendyOne",
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        'Are you sure you want to reset the game?',
        style: TextStyle(
          color: Colors.black,
          fontSize: SizeConfig.smallText1,
          fontFamily: "wendyOne",
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
            'Cancel',
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
          onPressed: () {
            SaveUtils.instance.clearGameBox();
            Navigator.of(context).pop();
          },
          child: Text(
            'Reset',
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
