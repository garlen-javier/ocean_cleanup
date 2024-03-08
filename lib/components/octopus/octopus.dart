import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/sprite.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:ocean_cleanup/components/lightning.dart';
import 'package:ocean_cleanup/extensions/random_range.dart';
import 'package:ocean_cleanup/worlds/game_world.dart';
import 'dart:async' as dartAsync;
import '../../constants.dart';
import '../../mixins/update_mixin.dart';
import '../../scenes/game_scene.dart';
import '../../utils/math_utils.dart';
import 'octopus_state_controller.dart';

enum OctopusAnimationState {
  normal,
  transform,
  angry
}

class Octopus extends SpriteAnimationGroupComponent with UpdateMixin, HasGameRef<GameScene> {

  VoidCallback? onAngry;
  VoidCallback? onStopAttack;
  Octopus ({this.onAngry,this.onStopAttack});

  final Random _random = Random();
  Vector2 _velocityDir = Vector2.zero();
  double _speed = 80;
  bool _isReverse = false;
  bool irritated = false;
  OctopusStateController? _stateController;

  @override
  Future<void> onLoad() async {
    Image image = gameRef.images.fromCache(pathOctopus);
    final spritesheet = SpriteSheet(
        image: image ,
        srcSize: Vector2(image.size.x/4,image.size.y/3)
    );

    final normal = spritesheet.createAnimation(row:0,stepTime: 0.25);
    final transform = spritesheet.createAnimation(row:1,stepTime: 0.25,loop: false);
    final angry = spritesheet.createAnimation(row:2,stepTime: 0.25);

    animations = {
      OctopusAnimationState.normal: normal,
      OctopusAnimationState.transform: transform,
      OctopusAnimationState.angry: angry,
    };

    current = OctopusAnimationState.transform;
    anchor = Anchor.center;

    await add(_stateController = OctopusStateController(this));
    _spawnAtRandom();
    _initRandomMove();
    debugMode = false;
    return super.onLoad();
  }

  void _spawnAtRandom()
  {
    double x = _random.nextDoubleInRange(min: width * 0.5, max: GameWorld.bounds.width - width * 0.5);
    double y = _random.nextDoubleInRange(min: height * 0.5, max: GameWorld.bounds.height - height * 0.5);
    position = Vector2(x, y);
  }

  void _initRandomMove()
  {
    if(_isPositionXOut || _isPositionYOut)
      _reverseDirection();
    else
      _randomizeDirection();

    add(
        TimerComponent(
          period: 6,
          repeat: true,
          onTick: () {
            if(!(_isPositionXOut || _isPositionYOut)) {
              _randomizeDirection();
            }
          },
        )
    );
  }

  void _randomizeDirection()
  {
     double angleDir = _random.nextDouble() * MathUtils.tau;
     _velocityDir = MathUtils.angleRadToDir(angleDir);
  }

  @override
  void runUpdate(double dt) {
    _stateController?.runUpdate(dt);
  }

  void makeMovement(double dt)
  {
    _tryReverseDirection();
    position += _velocityDir * _speed * dt;
  }

  void _tryReverseDirection()
  {
    if(!_isReverse && (_isPositionXOut || _isPositionYOut))
      _reverseDirection();
    else if(_isReverse && !(_isPositionXOut || _isPositionYOut))
      _isReverse = false;
  }

  void _reverseDirection()
  {
    bool isRightSide = position.x > GameWorld.bounds.width * 0.5;
    _velocityDir.x = isRightSide ? -1 : 1;
    _velocityDir.y*=-1;
    _isReverse = true;
  }


  bool get _isPositionXOut => position.x < width * 0.5 || position.x > GameWorld.bounds.width - width * 0.5;
  bool get _isPositionYOut => position.y < height * 0.5 || position.y > GameWorld.bounds.height - height  * 0.5;

}