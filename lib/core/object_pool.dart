
import 'package:flame/components.dart';

class ObjectPool<T extends SpriteComponent> {
  final List<T> _pool = [];
  final int _maxSize;
  final Function() _createInstance;

  ObjectPool(this._maxSize, this._createInstance) {
    for (int i = 0; i < _maxSize; i++) {
      _pool.add(_createInstance());
    }
  }

  T get() {
    if (_pool.isNotEmpty) {
      SpriteComponent obj = _pool.removeLast();
      obj.opacity = 1;
      return _pool.removeLast();
    } else {
      return _createInstance();
    }
  }

  void put(T object) {
    if (_pool.length < _maxSize) {
      object.opacity = 0;
      _pool.add(object);
    }
  }
}
