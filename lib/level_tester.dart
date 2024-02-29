
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocean_cleanup/utils/utils.dart';
import 'levels/level_parameters.dart';
import 'levels/levels.dart';
import 'main.dart';

class LevelTester extends StatelessWidget {
  const LevelTester({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Level Tester',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home:  TesterPage(),
    );
  }
}

class TesterPage extends StatelessWidget {
   TesterPage({super.key});

  final GlobalKey<FormFieldState> _playerSpeedKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _animalTrashChanceKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _trashSpawnMinKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _trashSpawnMaxKey = GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> _trashGoalKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _timeLimitKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _trashSpeedKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _sharkCountKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _sharkSpeedKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _animalTrashGoalKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _animalTimeLimitKey = GlobalKey<FormFieldState>();

  static const double DEFAULT_FONT_SIZE = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text("Level Tester",style: TextStyle(fontWeight: FontWeight.bold)),
                  _textField(context,_playerSpeedKey,"PlayerSpeed :","150"),

                  _textField(context,_trashGoalKey,"Trash Goal Count :","25"),
                  _textField(context,_trashSpeedKey,"Trash Speed :","0.5"),
                  _textField(context,_timeLimitKey,"Time Limit(in minutes) :","2"),

                  _textField(context,_trashSpawnMinKey,"Trash Spawn Min Chance :","1"),
                  _textField(context,_trashSpawnMaxKey,"Trash Spawn Max Chance :","15"),

                  _textField(context,_sharkCountKey,"Shark Count :","2"),
                  _textField(context,_sharkSpeedKey,"Shark Speed :","100"),

                  _textField(context,_animalTrashGoalKey,"Animal Trash Goal :","5"),
                  _textField(context,_animalTrashChanceKey,"Animal Trash Chance(percentage) :","0.6"),
                  _textField(context,_animalTimeLimitKey,"Animal Time Limit(in minutes) :","1"),
                  const SizedBox(height: 28,),
                  Card(
                    child: CupertinoButton(
                        padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                        onPressed: () {

                           _runTestLevel(context);
                        },
                        child: const Text(
                          "Start Game",
                          style:  TextStyle(fontSize: 14),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _runTestLevel(BuildContext context)
  {
    double playerSpeed = double.parse(_playerSpeedKey.currentState!.value);
    double trashSpeed = double.parse(_trashSpeedKey.currentState!.value);
    double animalTrashChance = double.parse(_animalTrashChanceKey.currentState!.value);
    double trashSpawnMin = double.parse(_trashSpawnMinKey.currentState!.value);
    double trashSpawnMax = double.parse(_trashSpawnMaxKey.currentState!.value);
    double sharkSpeed = double.parse(_sharkSpeedKey.currentState!.value);
    int sharkCount = int.parse(_sharkCountKey.currentState!.value);

    TrashObjective mainMission = TrashObjective(
        trashType: TrashType.any,
        goal: int.parse(_trashGoalKey.currentState!.value),
        timeLimit: Utils.minuteToSeconds(double.parse(_timeLimitKey.currentState!.value)));

    TrashObjective animalMission = TrashObjective(
        trashType: TrashType.plasticCup,
        goal: int.parse(_animalTrashGoalKey.currentState!.value),
        timeLimit: Utils.minuteToSeconds(double.parse(_animalTimeLimitKey.currentState!.value)));

    Levels.instance.createTestLevel(playerSpeed, trashSpeed, animalTrashChance, trashSpawnMin, trashSpawnMax, sharkSpeed, sharkCount, mainMission, animalMission);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const GamePage()));
  }

  Widget _textField(BuildContext context,GlobalKey<FormFieldState> key,String label,String defaultValue) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontSize:DEFAULT_FONT_SIZE)),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: 200,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                    border: Border.all(color: Colors.black38)),
                child: TextFormField(
                  initialValue: defaultValue,
                  key: key,
                  style:
                  const TextStyle(fontSize: DEFAULT_FONT_SIZE),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}

