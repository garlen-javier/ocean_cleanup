import 'brick_base_body.dart';

class BrickBody extends BrickBaseBody {
  BrickBody({required super.pos, required super.width, required super.height});

  @override
  Future<void> onLoad() {
    renderBody = false;
    return super.onLoad();
  }
}