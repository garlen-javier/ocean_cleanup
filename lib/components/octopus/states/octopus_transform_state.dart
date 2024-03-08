

import '../octopus.dart';
import '../octopus_state_controller.dart';
import 'octopus_angry_state.dart';

class OctopusTransformState extends OctopusState {
  OctopusTransformState(super.controller);

  @override
  void onEnter(Object? args) {
    controller.octopus.current = OctopusAnimationState.transform;
    controller.octopus.animationTickers?[OctopusAnimationState.transform]?.onComplete = () {
      controller.changeState<OctopusAngryState>();
    };
  }

  @override
  void onRunUpdate(double dt) {

  }

  @override
  void onUpdate(double dt) {

  }

  @override
  void onExit() {

  }


}


