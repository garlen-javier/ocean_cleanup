import 'package:flutter/material.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

class LevelCard extends StatelessWidget {
  final int level;
  final String time;
  final String trashGoal;
  final List<Color> colors;

  const LevelCard(this.level, this.time, this.trashGoal, this.colors,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 13),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            colors[0],
            colors[1],
          ],
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/stopwatch.png',
                      width: SizeConfig.smallText1,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.smallText1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/plastic.png',
                      width: SizeConfig.smallText1,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      trashGoal,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.smallText1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              'L $level',
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.largeText1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
