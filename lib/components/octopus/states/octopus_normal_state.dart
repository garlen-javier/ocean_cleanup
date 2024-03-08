

import '../octopus.dart';
import '../octopus_state_controller.dart';
import 'octopus_transform_state.dart';

class OctopusNormalState extends OctopusState {
  OctopusNormalState(super.controller);

  @override
  void onEnter(Object? args) {
    controller.octopus.current = OctopusAnimationState.normal;
  }

  @override
  void onRunUpdate(double dt) {
    controller.octopus.makeMovement(dt);
    if(controller.octopus.irritated)
    {
        controller.changeState<OctopusTransformState>();
    }
  }

  @override
  void onUpdate(double dt) {
  }

  @override
  void onExit() {

  }


}


