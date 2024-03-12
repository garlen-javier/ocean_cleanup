import 'package:firebase_core/firebase_core.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flame/flame.dart';
import 'package:ocean_cleanup/bloc/game/connection_bloc.dart';
import 'package:ocean_cleanup/bloc/game/connection_event.dart';
import 'package:ocean_cleanup/screens/game/game_view_screen.dart';
import 'package:ocean_cleanup/screens/leaderboard/leaderboard_screen.dart';
import 'package:ocean_cleanup/screens/levels/levels_screen.dart';
import 'package:ocean_cleanup/utils/save_utils.dart';
import 'bloc/game/game_bloc.dart';
import 'bloc/game_stats/game_stats_bloc.dart';
import 'constants.dart';
import 'package:ocean_cleanup/bloc/auth/auth_bloc.dart';
import 'package:ocean_cleanup/firebase_options.dart';
import 'package:ocean_cleanup/screens/intro%20game/intro_game_screen.dart';
import 'package:ocean_cleanup/utils/config_size.dart';
import 'screens/level_tester.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SaveUtils.instance.loadData();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  FlameAudio.bgm.initialize();
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
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => NetworkBloc()..add(NetworkObserve()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/home",
        routes: {
          "/home": (context) => const IntroGameScreen(),
          "/levels": (context) => const LevelsScreen(),
          "/leaderboard": (context) => const LeaderboardScreen(),
        },
      ),
    );
  }
}
