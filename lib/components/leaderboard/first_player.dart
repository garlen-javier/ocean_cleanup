import 'package:flutter/material.dart';
import 'package:ocean_cleanup/models/user_model.dart';

Expanded firstPlayer(UserModel user) {
  return Expanded(
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: CircleAvatar(
                radius: 68,
                backgroundColor: const Color(0xffFFE54D),
                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: const Color(0xff86A0FA),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50,
                    child: Image.asset("assets/images/Sad_Turtle_01_1.png"),
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
                  backgroundColor: Color(0xffFFCC4D),
                  radius: 19,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Color(0xffFDE256),
                    child: Text(
                      "1",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xffF99D26),
                        fontWeight: FontWeight.bold,
                        fontFamily: "wendyOne",
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
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            fontFamily: "wendyOne",
          ),
        ),
        Text(
          user.score.toString(),
          style: const TextStyle(
            color:  Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            fontFamily: "wendyOne",
          ),
        ),
      ],
    ),
  );
}
