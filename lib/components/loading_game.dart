
import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class LoadingGame extends PositionComponent
{
  final TextPaint _textPaint = TextPaint(
    style: const TextStyle(color: Colors.blueGrey, fontSize: 60),
  );

  late Size _screnSize;

  @override
  FutureOr<void> onLoad() {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    double w = view.physicalSize.width / view.devicePixelRatio;
    double h = view.physicalSize.height / view.devicePixelRatio;
    _screnSize = Size(w, h);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawColor(const Color(0xFFf1feff), BlendMode.modulate);
    _textPaint.render(
      canvas,
      "Loading...",
      anchor: Anchor.center,
      Vector2(_screnSize.width * 0.5,_screnSize.height * 0.5),
    );
  }

}