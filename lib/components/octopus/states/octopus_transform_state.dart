

import 'package:ocean_cleanup/components/octopus/states/octopus_normal_state.dart';

import '../octopus.dart';
import '../octopus_state_controller.dart';
import 'octopus_angry_state.dart';

class OctopusTransformState extends OctopusState {
  OctopusTransformState(super.controller);

  @override
  void onEnter(Object? args) {
    if(controller.octopus.current == OctopusAnimationState.normal) {
      controller.octopus.current = OctopusAnimationState.transform;
      controller.octopus.animationTickers?[OctopusAnimationState.transform]
          ?.onComplete = () {
        controller.changeState<OctopusAngryState>();
      };
    }else if(controller.octopus.current == OctopusAnimationState.angry){
      controller.octopus.current = OctopusAnimationState.transformReverse;
      controller.octopus.animationTickers?[OctopusAnimationState.transformReverse]
          ?.onComplete = () {
        controller.changeState<OctopusNormalState>();
      };
    }
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


