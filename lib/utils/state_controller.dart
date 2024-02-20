import 'package:flame/components.dart';

abstract class State {
  void onEnter(Object? args);
  void onUpdate();
  void onExit();
}

abstract class StateController extends Component {
  State? _currentState;

  final Map<Type, Function()> _stateConstructors = {};

  @override
  void update(double dt) {
    super.update(dt);
    _currentState?.onUpdate();
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
      _currentState = constructor() as State;
      _currentState!.onEnter(args);
    }
  }
}
