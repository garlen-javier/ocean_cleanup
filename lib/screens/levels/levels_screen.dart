import 'package:flutter/material.dart';

class LevelsScreen extends StatefulWidget {
  final String username;
  const LevelsScreen({super.key , required this.username});

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text('Levels Screen ${widget.username}'),
      ),
    );
  }
}