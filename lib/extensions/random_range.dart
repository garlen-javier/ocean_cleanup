

import 'dart:math';

extension RandomRangeExtension on Random {

  ///min = 5 and max = 10,It will not output exactly 10.0, but it can output any value between 5.0 (inclusive) and 10.0 (exclusive).
  double nextDoubleInRange({required double min,required  double max}) {
    return min + nextDouble() * (max - min);
  }

  ///min = 5 and max = 10, the generated random integers will be 5, 6, 7, 8, and 9, but 10 will not appear.
  int nextIntInRange({required int min,required int max}) {
    return min + nextInt(max - min);
  }

}