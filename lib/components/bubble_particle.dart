


import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';

class BubbleParticle extends ParticleSystemComponent {

  Vector2 from;
  Vector2 to;
  Sprite sprite;
  double defaultSize;
  double lifeSpan;
  List<double>? randomSizes;

  BubbleParticle({required this.from,
    required this.to,
    required this.sprite,
    this.lifeSpan = 10,
    this.defaultSize = 12,
    this.randomSizes
  })
      : super(
    particle: MovingParticle(
        from: from,
        to: to,
        lifespan: lifeSpan,
        child:
        SpriteParticle(
          sprite: sprite,
          size: Vector2(randomSizes?.first ?? defaultSize,randomSizes?.first ?? defaultSize),
        ),
      ),
  );

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    return super.onLoad();
  }
}