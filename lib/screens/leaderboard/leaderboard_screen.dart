import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ocean_cleanup/components/leaderboard/first_player.dart';
import 'package:ocean_cleanup/components/leaderboard/second_player.dart';
import 'package:ocean_cleanup/components/leaderboard/third_player.dart';
import 'package:ocean_cleanup/models/user_model.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<LeaderboardScreen> {
  List<UserModel> users = [];

  Future<List<UserModel>> getListUser() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('score', descending: true)
        .get();

    var names = List.from(data.docs.map((doc) => doc['username']));
    var scores = List.from(data.docs.map((doc) => doc['score']));

    for (var i = 0; i < names.length; i++) {
      users.add(UserModel(username: names[i], score: scores[i] , id: data.docs[i].id));
    }

    inspect(users);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/leaderboard_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        body: FutureBuilder<List<UserModel>>(
            future: getListUser(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(
                      child: Lottie.asset(
                        'assets/animations/loading.json',
                        width: 100,
                        height: 100,
                      ),
                    )
                  : snapshot.data!.length >= 3
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        firstPlayer(snapshot.data![0])
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 60,
                                    left: .0,
                                    right: .0,
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        secondPlayer(snapshot.data![1]),
                                        const Spacer(
                                          flex: 2,
                                        ),
                                        thirdPlayer(snapshot.data![2]),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFBC52C6),
                                        Color(0xFF595CFF),
                                      ],
                                      begin: FractionalOffset(0.0, 0.0),
                                      end: FractionalOffset(0.0, 1.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  width: SizeConfig.screenWidth,
                                  height: 68,
                                  child: Row(
                                    children: [
                                      const Spacer(),
                                      const Text(
                                        '#1',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xffE8E8E8),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        snapshot.data![0].username,
                                        style: const TextStyle(
                                          color: Color(0xffE8E8E8),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const Spacer(
                                        flex: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          snapshot.data![0].score.toString(),
                                          style: const TextStyle(
                                            color: Color(0xffE8E8E8),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length - 1,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Container(
                                        width: SizeConfig.screenWidth,
                                        height: 68,
                                        color: const Color(0xff060718)
                                            .withOpacity(0.8),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '#${(index + 2).toString()}',
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Color(0xffE8E8E8),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    snapshot.data![index + 1]
                                                        .username,
                                                    style: const TextStyle(
                                                      color: Color(0xffE8E8E8),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  snapshot
                                                      .data![index + 1].score
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Color(0xffE8E8E8),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      : const Center(
                          child: Text(
                            "No Users",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
            }),
      ),
    );
  }
}
