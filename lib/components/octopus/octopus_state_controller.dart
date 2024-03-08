
import '../../framework/state_controller.dart';
import 'octopus.dart';
import 'states/octopus_state_barrel.dart';

abstract class OctopusState implements State
{
  final OctopusStateController _controller;
  OctopusState(this._controller);

  OctopusStateController get controller => _controller;
  Octopus get trash => _controller.octopus;

  @override
  void onEnter(Object? args);
  @override
  void onRunUpdate(double dt);
  @override
  void onExit();
}

class OctopusStateController extends StateController {

  final Octopus octopus;
  OctopusStateController(this.octopus) {
    registerStateHandler<OctopusNormalState>(() => OctopusNormalState(this));
    registerStateHandler<OctopusTransformState>(() => OctopusTransformState(this));
    registerStateHandler<OctopusAngryState>(() => OctopusAngryState(this));

    changeState<OctopusNormalState>();
  }
}