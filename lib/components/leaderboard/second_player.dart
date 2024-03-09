import 'package:flutter/material.dart';
import 'package:ocean_cleanup/models/user_model.dart';

Column secondPlayer(UserModel user) {
  return Column(
    children: [
      Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: CircleAvatar(
              radius: 48,
              backgroundColor: const Color(0xffCED5E0),
              child: CircleAvatar(
                radius: 45,
                backgroundColor: const Color(0xff26CE55),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 33,
                  child: Image.asset("assets/images/Sad_Crab_01_6.png"),
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
                backgroundColor: Color(0xffCED5E0),
                radius: 19,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xffEFF1F4),
                  child: Text(
                    "2",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xffB3BAC3),
                      fontWeight: FontWeight.bold,
                      fontFamily: "wendyOne",
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      Text(
        user.username,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          fontFamily: "wendyOne",
        ),
      ),
      Text(
        user.score.toString(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          fontFamily: "wendyOne",
        ),
      ),
    ],
  );
}
