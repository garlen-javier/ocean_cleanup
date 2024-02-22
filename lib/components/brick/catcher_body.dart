
import 'package:ocean_cleanup/components/brick/brick_base_body.dart';

class CatcherBody extends BrickBaseBody
{
  CatcherBody({required super.pos, required super.width, required super.height});

  @override
  Future<void> onLoad() async {
    debugMode = true;
    return super.onLoad();
  }
}