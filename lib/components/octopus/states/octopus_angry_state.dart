


import 'package:flame/components.dart';
import '../octopus.dart';
import '../octopus_state_controller.dart';
import 'octopus_transform_state.dart';

class OctopusAngryState extends OctopusState {
  OctopusAngryState(super.controller);

  Timer? _countdown;
  final double _timeLimit = 12;

  @override
  void onEnter(Object? args) {
    controller.octopus.current = OctopusAnimationState.angry;
    controller.octopus.onAngry?.call();
    if(_countdown == null)
      _countdown = Timer(_timeLimit);
    else
      _countdown!.start();
  }

  @override
  void onRunUpdate(double dt) {
    _countdown?.update(dt);
    if(_countdown!.finished)
    {
      controller.octopus.irritated = false;
      controller.changeState<OctopusTransformState>();
      controller.octopus.onStopAttack?.call();
      _countdown!.stop();
    }
  }

  @override
  void onUpdate(double dt) {
  }

  @override
  void onExit() {

  }


}


