import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../../bloc/player_movement/player_movement_barrel.dart';
import 'player_sprite.dart';

class Player extends BodyComponent {

  final Vector2 pos;
  final double width;
  final double height;

  Player(this.pos,this.width,this.height):super();

  Vector2 velocity = Vector2.zero();
  double speed = 300;
  late PlayerSprite sprite;

  @override
  Future<void> onLoad() async {
    sprite = PlayerSprite();
    await add(sprite);
    //renderBody = false;
    await _initBlocListener();
    return super.onLoad();
  }

  Future<void> _initBlocListener() async {
    await add(
      FlameBlocListener<PlayerMovementBloc, PlayerMovementState>(
        listenWhen: (previousState, newState) {
          return previousState.velocityDirection != newState.velocityDirection;
        },
        onNewState: (state) {
          velocity= state.velocityDirection;
        },
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    body.linearVelocity+= velocity * speed * dt;
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      userData: this,
      position: pos,
      gravityScale: Vector2.zero(),
      linearDamping: 3,
      fixedRotation: true,
    );

    final shape = PolygonShape()..setAsBoxXY(width,height);
    final body = world.createBody(bodyDef);
    body.createFixtureFromShape(shape);
    return body;
  }


}