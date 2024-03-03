import 'package:flutter/material.dart';
import 'package:ocean_cleanup/models/user_model.dart';

Column thirdPlayer(UserModel user) {
  return Column(
    children: [
      Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: CircleAvatar(
              radius: 48,
              backgroundColor: const Color(0xff8B5731),
              child: CircleAvatar(
                radius: 45,
                backgroundColor: const Color(0xffF5A6FC),
                child: CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.transparent,
                  child: Image.asset("assets/images/Dolphin_01_1.png"),
                ),
              ),
            ),
          ),
          const Positioned(
            top: .0,
            left: .0,
            right: .0,
            child: Center(
              child: CircleAvatar(
                radius: 19,
                backgroundColor: Color(0xff8B5731),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xffBF7540),
                  child: Text(
                    "3",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff8B5731),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      Text(
        user.username,
        style: const TextStyle(
          color: Color(0xffE8E8E8),
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
      Text(
        user.score.toString(),
        style: const TextStyle(
          color: Color(0xffE8E8E8),
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    ],
  );
}
