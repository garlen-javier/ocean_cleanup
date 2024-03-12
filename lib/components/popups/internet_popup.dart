import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

class InternetPopup extends StatelessWidget {
  const InternetPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: Color(0xFF6874ca), width: 5),
      ),
      backgroundColor: Colors.white,
      title: Text(
        'No Internet',
        style: TextStyle(
          color: Colors.orange,
          fontSize: SizeConfig.mediumText1,
          fontWeight: FontWeight.bold,
          fontFamily: "wendyOne",
        ),
        textAlign: TextAlign.center,
      ),
      content: Column(
        children: [
          Lottie.asset(
            "assets/animations/No_internet.json",
            height: SizeConfig.screenHeight / 2.5,
          ),
        ],
      ),
      
    );
  }
}
