import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:ocean_cleanup/components/octopus/octopus.dart';
import '../../constants.dart';
import '../../mixins/update_mixin.dart';
import '../core/game_scene.dart';
import '../../worlds/game_world.dart';

enum LightningDirection { horizontal, vertical }

class Lightning extends SpriteComponent
    with UpdateMixin, CollisionCallbacks, HasGameRef<GameScene> {
  Vector2 from;
  Vector2 to;
  List<Vector2> upperDir = [];
  List<Vector2> lowerDir = [];
  LightningDirection direction;
  double speed = 100;

  Lightning({
    required this.from,
    required this.to,
    required this.upperDir,
    required this.lowerDir,
    required this.direction,
    this.speed = 100,
  });

  late CircleHitbox hitbox;
  final double _rotSpeed = 8.0;
  Vector2 _velocityDir = Vector2.zero();
  final Random _random = Random();
  bool _canMove = false;

  @override
  FutureOr<void> onLoad() async {
    sprite = Sprite(gameRef.images.fromCache(pathLightning));
    anchor = Anchor.center;

    _setVelocityDir(from, to);
    _addMoveDelay();
    _listenRemoveByOctopus();
    await add(hitbox = CircleHitbox(
        radius: size.x * 0.4, position: Vector2(size.x * 0.1, size.y * 0.1)));
    // debugMode = true;
    return super.onLoad();
  }

  void _addMoveDelay() {
    add(TimerComponent(
      period: _random.nextDouble() * 6,
      repeat: true,
      //removeOnFinish: true,
      onTick: () => _canMove = true,
    ));
  }

  void _setVelocityDir(Vector2 from, Vector2 to) {
    Vector2 fromOffset = Vector2(from.x + width * 0.5, from.y - height * 0.5);
    Vector2 toOffset = Vector2(to.x + height * 0.5, to.y - height * 0.5);
    position = fromOffset;

    Vector2 dir = toOffset - fromOffset;
    _velocityDir = dir.normalized();
  }

  @override
  void runUpdate(double dt) {
    if (!_canMove) {
      return;
    }

    angle += _rotSpeed * dt;
    position += _velocityDir * 100 * dt;
    _randomBounceWithDirection();
  }

  void _randomBounceWithDirection() {
    if (direction == LightningDirection.horizontal) {
      if (_velocityDir.x > 0 &&
          position.x > GameWorld.bounds.width + width * 0.5) {
        _randomBounce(upperDir, lowerDir);
      } else if (_velocityDir.x < 0 && position.x < width * 0.5) {
        _randomBounce(lowerDir, upperDir);
      }
    } else if (direction == LightningDirection.vertical) {
      if (_velocityDir.y > 0 &&
          position.y > GameWorld.bounds.height + height * 0.5) {
        _randomBounce(lowerDir, upperDir);
      } else if (_velocityDir.y < 0 && position.y < height * 0.5) {
        _randomBounce(upperDir, lowerDir);
      }
    }
  }

  void _randomBounce(List<Vector2> pFromList, List<Vector2> pToList) {
    int rng = _random.nextInt(pFromList.length);
    Vector2 from = pFromList[rng];
    Vector2 to = pToList[rng];
    _setVelocityDir(from, to);
    _canMove = false;
  }

  void _listenRemoveByOctopus() {
    gameRef.componentsNotifier<Octopus>().addListener(() async {
      hitbox.removeFromParent();
      await add(
        OpacityEffect.fadeOut(
          EffectController(
            duration: 0.5,
          ),
        )..onComplete = () {
            removeFromParent();
          },
      );
    });
  }
}
