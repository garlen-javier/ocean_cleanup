import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

class FinalMissionPopup extends StatelessWidget {
  const FinalMissionPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: Color(0xFF6874ca), width: 5),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Final Mission",
              style: TextStyle(
                color: const Color(0xFF6874ca),
                fontSize: SizeConfig.largeText1,
                fontWeight: FontWeight.bold,
                fontFamily: "wendyOne",
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'The Octopus Queen is enraged by the pollution in her ocean realm.\n Master the art of recycling by gathering similar pieces of trash \n within the allotted time to reduce her anger meter. Should you fail, \n brace yourself for her formidable wrath!!',
              style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.smallText1,
                fontFamily: "wendyOne",
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF6874ca)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "wendyOne",
                  fontSize: SizeConfig.smallText1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
