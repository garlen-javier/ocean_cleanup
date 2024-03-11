import 'package:flutter/material.dart';
import 'package:ocean_cleanup/components/popups/tutorials/introduction_one_popup.dart';
import 'package:ocean_cleanup/screens/levels/levels_screen.dart';
import 'package:ocean_cleanup/utils/save_utils.dart';

class IntroGameScreen extends StatefulWidget {
  const IntroGameScreen({super.key});

  @override
  State<IntroGameScreen> createState() => _IntroGameScreenState();
}

class _IntroGameScreenState extends State<IntroGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 390),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  "assets/images/Game_Title4x 1.png",
                  width: MediaQuery.of(context).size.width / 3,
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LevelsScreen(),
                      ),
                    );
                    bool tuto1 = SaveUtils.instance.getTutorialStatus("tuto1");
                    if (!tuto1) {
                      Future.delayed(const Duration(seconds: 1), () {
                        showIntroOnePopup(context);
                      });
                    }
                  },
                  child: Image.asset('assets/images/Play_Button4x 1.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
