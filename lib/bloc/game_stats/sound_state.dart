import 'dart:async';

class SoundStateBloc {
  bool _isSoundOn = true;
  final _soundController = StreamController<bool>();

  Stream<bool> get soundState => _soundController.stream;
  bool get isSoundOn => _isSoundOn;

  void toggleSound() {
    _isSoundOn = !_isSoundOn;
    _soundController.sink.add(_isSoundOn);
  }

  void dispose() {
    _soundController.close();
  }
}