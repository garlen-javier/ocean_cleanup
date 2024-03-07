import 'package:flutter/material.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

void showIntroThreePopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Image.asset(
          'assets/images/tutorials/Introduction_two.png',
          width: SizeConfig.screenWidth / 2,
          fit: BoxFit.contain,
        ),
      );
    },
  );
}
