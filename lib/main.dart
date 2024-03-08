import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flame/flame.dart';
import 'package:ocean_cleanup/utils/save_utils.dart';
import 'bloc/game/game_bloc.dart';
import 'bloc/game_stats/game_stats_bloc.dart';
import 'constants.dart';
import 'level_tester.dart';
import 'package:ocean_cleanup/bloc/auth/auth_bloc.dart';
import 'package:ocean_cleanup/firebase_options.dart';
import 'package:ocean_cleanup/screens/intro%20game/intro_game_screen.dart';
import 'package:ocean_cleanup/utils/config_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SaveUtils.instance.loadData();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  if (!isTesterMode)
    runApp(const MyApp());
  else
    runApp(const LevelTester());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(create: (_) => GameBloc()),
        BlocProvider<GameStatsBloc>(create: (_) => GameStatsBloc()),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroGameScreen(),
      ),
    );
  }
}
