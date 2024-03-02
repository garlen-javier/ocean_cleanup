
import 'package:flame/components.dart';

class ObjectPool<T extends Component> {
  final List<T> _pool = [];
  final int _maxSize;
  final Function() _createInstance;

  ObjectPool(this._maxSize, this._createInstance) {
    for (int i = 0; i < _maxSize; i++) {
      _pool.add(_createInstance());
    }
  }

  T getObjectFromPool() {
    if (_pool.isNotEmpty) {
      return _pool.removeLast();
    } else {
      return _createInstance();
    }
  }

  void returnObjectToPool(T object) {
    _pool.add(object);
    object.removeFromParent();
  }

  void clearPool()
  {
    _pool.clear();
  }

  int get poolSize => _pool.length;
}
