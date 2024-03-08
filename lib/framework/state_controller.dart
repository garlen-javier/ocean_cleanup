import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

abstract class State {
  void onEnter(Object? args);
  ///Manually runs update from state controller
  void onRunUpdate(double dt);
  ///Overrides and call the update from component itself
  void onUpdate(double dt);
  void onExit();
}

abstract class StateController extends Component {
  State? _currentState;

  final Map<Type, Function()> _stateConstructors = {};

  @override
  void update(double dt) {
    _currentState?.onUpdate(dt);
    super.update(dt);
  }

  void runUpdate(double dt)
  {
    _currentState?.onRunUpdate(dt);
  }

  Type? get state => _currentState?.runtimeType;

  State? get stateHandler => _currentState;

  void registerStateHandler<T extends State>(T Function() constructor) {
    _stateConstructors[T] = constructor;
  }

  void releaseStateHandler<T extends State>() {
    _stateConstructors.remove(T);
  }

  void changeState<T extends State>([Object? args]) {
    final next = T;

    _currentState?.onExit();
    final constructor = _stateConstructors[next];
    if (constructor != null) {
     // debugPrint("Previous State: $_currentState");
      _currentState = constructor() as State;
     // debugPrint("New State: $_currentState");
      _currentState!.onEnter(args);
    }
  }
}
