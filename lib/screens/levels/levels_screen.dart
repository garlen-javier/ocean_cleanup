import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:ocean_cleanup/bloc/auth/auth_bloc.dart';
import 'package:ocean_cleanup/components/levels/level_item.dart';
import 'package:ocean_cleanup/screens/leaderboard/leaderboard_screen.dart';

class LevelsScreen extends StatefulWidget {
  final String username;
  const LevelsScreen({super.key, required this.username});

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  final List<String> time = ["1.5", "2", "2.5", "3"];
  final List<String> trash = ["0", "8", "10", "15"];
  final List<Color> colorprimary = [
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.red
  ];
  final List<Color> colorSecondary = [
    Colors.orange,
    Colors.cyan,
    Colors.teal,
    Colors.pink
  ];

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Levels',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Text(
            widget.username,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () {
              authBloc.signOut(context);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LeaderboardScreen(),
                ),
              );
            },
            child: Align(
              alignment: Alignment.bottomRight,
              child: Lottie.asset(
                "assets/animations/leaderboard.json",
                repeat: false,
                height: 100,
                width: 100,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double screenWidth = constraints.maxWidth;
                double screenHeight = constraints.maxHeight;
                double cardWidth = screenWidth * 0.4;
                double cardHeight = screenHeight * 0.2;

                return GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: cardWidth / cardHeight,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  padding: const EdgeInsets.all(10.0),
                  shrinkWrap: true,
                  children: List.generate(
                    4,
                    (index) => LevelCard(
                      index + 1,
                      time[index],
                      trash[index],
                      [colorprimary[index], colorSecondary[index]],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
