

import 'package:flame_audio/bgm.dart';
import 'package:flame_audio/flame_audio.dart';

extension BgmFilenameExtension on Bgm {

  ///Get the path file name of the current playing bgm
  ///returns "" empty string if not played anything from start.
  ///otherwise it will return the latest played audiosource filename.
  String get currentSourcePath {
    String fileName = "";
    if(FlameAudio.bgm.audioPlayer.source is AssetSource) {
      fileName = (FlameAudio.bgm.audioPlayer.source as AssetSource).path;
    }
    return fileName;
  }

}