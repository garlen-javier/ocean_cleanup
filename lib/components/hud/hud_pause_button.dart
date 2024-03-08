import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';

import '../../bloc/game/game_barrel.dart';

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

  bool _isSelected = false;

  @override
  Future<void> onLoad() async {
    add(defaultSkin);
    add(selectedSkin);
    size = defaultSkin.size * 1.5;
    anchor = Anchor.center;
    selectedSkin.opacity = 0;
    _initBlocListener();
  }

  Future<void> _initBlocListener() async {
    await add(
    FlameBlocListener<GameBloc, GameState>(
      listenWhen: (previousState, newState) {
        return previousState != newState;
      },
      onNewState: (state)  {
        switch(state.phase)
        {
          case GamePhase.playing:
            defaultState();
            break;
          case GamePhase.pause:
            selectedState();
            break;
          default:
            break;
        }
      },
    ),
    );
  }

  void toggle()
  {
    _isSelected = !_isSelected;
    _toggleState(_isSelected);
  }

  void defaultState()
  {
    _isSelected = false;
    _toggleState(_isSelected);
  }

  void selectedState()
  {
    _isSelected = true;
    _toggleState(_isSelected);
  }

  void _toggleState(bool isSelected)
  {
    defaultSkin.opacity = (isSelected) ? 0 : 1;
    selectedSkin.opacity = (isSelected) ? 1 : 0;
  }

   @override
  void onTapUp(TapUpEvent event) {
     onPressDown?.call(this);
    super.onTapUp(event);
  }
}