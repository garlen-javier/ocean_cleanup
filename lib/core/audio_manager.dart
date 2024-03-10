

import 'package:flame_audio/flame_audio.dart';
import 'package:ocean_cleanup/extensions/bgm_filename.dart';

import '../constants.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager.constructor();
  AudioManager.constructor();
  static AudioManager get instance => _instance;

  bool _isMuteBgm = false;
  bool _isMuteSfx = false;

  bool isBgmSourcePlayed(String fileName) =>  FlameAudio.bgm.currentSourcePath == fileName;
  bool get isBgmPaused => FlameAudio.bgm.audioPlayer.state == PlayerState.paused;
  bool get isBgmPlaying => FlameAudio.bgm.audioPlayer.state == PlayerState.playing;

  Future<void> preloadSfx() async {
    await FlameAudio.play(pathSfxLevelWin,volume: 0);
    await FlameAudio.play(pathSfxGameOver,volume: 0);
    await FlameAudio.play(pathSfxCatchTrash,volume: 0);
    await FlameAudio.play(pathSfxSwingNet,volume: 0);
    await FlameAudio.play(pathSfxReduceHealth,volume: 0);
    await FlameAudio.play(pathSfxAnimalRescued,volume: 0);
  }

  void muteBgm(isMute)
  {
    _isMuteBgm = isMute;
  }

  void muteSfx(isMute)
  {
    _isMuteSfx = isMute;
  }

  Future<void> playSfx(String pathName) async {
    double volume = (!_isMuteSfx) ? 1 : 0;
    await FlameAudio.play(pathName,volume: volume);
  }

  Future<void> playBgm(String pathName) async {
    double volume = (!_isMuteBgm) ? 1 : 0;
    await FlameAudio.bgm.play(pathName,volume: volume);
  }

  Future<void> stopBgm() async {
    if(FlameAudio.bgm.isPlaying)
        FlameAudio.bgm.stop();
  }

  Future<void> resumeBgm() async {
    if(isBgmPaused)
       FlameAudio.bgm.resume();
  }

  Future<void> pauseBgm() async {
    if(isBgmPlaying)
      FlameAudio.bgm.pause();
  }

}