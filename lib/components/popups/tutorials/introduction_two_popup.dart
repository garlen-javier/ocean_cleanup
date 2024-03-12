import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ocean_cleanup/utils/config_size.dart';
import 'package:ocean_cleanup/utils/save_utils.dart';

class IntroTwoPopup extends StatelessWidget {
  const IntroTwoPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/tutorials/intro_two.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  SaveUtils.instance.saveTutorialStatus("tuto1", true);
                },
                child: Image.asset(
                  'assets/images/tutorials/ready_button.png',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
