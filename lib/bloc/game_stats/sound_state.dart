import 'dart:async';

import 'package:ocean_cleanup/core/audio_manager.dart';

class SoundStateBloc {
  bool _isSoundOn = !AudioManager.instance.isMuteSfx;
  bool _isMusicOn = !AudioManager.instance.isMuteBgm;
  final _soundController = StreamController<bool>();
  final _musicController = StreamController<bool>();

  Stream<bool> get soundState => _soundController.stream;
  Stream<bool> get musicState => _musicController.stream;
  bool get isSoundOn => _isSoundOn;
  bool get isMusicOn => _isMusicOn;

  void toggleSound() {
    _isSoundOn = !_isSoundOn;
    _soundController.sink.add(_isSoundOn);
    if (_isSoundOn) {
      print("Sound is on");
      AudioManager.instance.muteSfx(false);
    } else {
      print("Sound is off");
      AudioManager.instance.muteSfx(true);
    }
  }

  void toggleMusic() {
    _isMusicOn = !_isMusicOn;
    _musicController.sink.add(_isMusicOn);
    if (_isMusicOn) {
      print("Music is on");
      AudioManager.instance.muteBgm(false);
    } else {
      print("Music is off");
      AudioManager.instance.muteBgm(true);
    }
  }

  void dispose() {
    _soundController.close();
    _musicController.close();
  }
}
