import 'package:flame/components.dart';
import 'package:flame/events.dart';

class HudPauseButton extends PositionComponent with TapCallbacks {

  final SpriteComponent defaultSkin;
  final SpriteComponent selectedSkin;
  Function(HudPauseButton)? onPressDown;

  HudPauseButton({
    required this.defaultSkin,
    required this.selectedSkin,
    this.onPressDown,
    super.position,
  });

  bool isSelected = false;

  @override
  Future<void> onLoad() async {
    add(defaultSkin);
    add(selectedSkin);
    size = defaultSkin.size * 1.5;
    anchor = Anchor.center;
    selectedSkin.opacity = 0;
  }

  void toggle()
  {
    isSelected = !isSelected;
    defaultSkin.opacity = (isSelected) ? 0 : 1;
    selectedSkin.opacity = (isSelected) ? 1 : 0;
  }

   @override
  void onTapUp(TapUpEvent event) {
     onPressDown?.call(this);
    super.onTapUp(event);
  }
}