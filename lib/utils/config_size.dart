import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  //text fontSize to be calculated by screen width
  static late double smallText1;
  static late double smallText2;
  static late double smallText3;
  static late double mediumText1;
  static late double mediumText2;
  static late double largeText1;
  static late double largeText2;

  static late double simpleBorderRadius;
  static late double normalpadding;
  static late bool isTablet;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    //for devices with large width (tablets)
    if (blockSizeHorizontal > 5) {
      smallText1 = blockSizeHorizontal * 2.3;
      smallText2 = blockSizeHorizontal * 3;
      smallText3 = blockSizeHorizontal * 2;
      mediumText1 = blockSizeHorizontal * 3.5;
      mediumText2 = blockSizeHorizontal * 4.2;
      largeText1 = blockSizeHorizontal * 4.6;
      largeText2 = blockSizeHorizontal * 5.1;
      simpleBorderRadius = blockSizeHorizontal * 1.4;
      normalpadding = blockSizeHorizontal * 2;
      isTablet = true;
    } else {
      simpleBorderRadius = blockSizeHorizontal * 2;
      normalpadding = blockSizeHorizontal;
      smallText1 = blockSizeHorizontal * 3.3;
      smallText2 = blockSizeHorizontal * 4;
      smallText3 = blockSizeHorizontal * 2.1;
      mediumText1 = blockSizeHorizontal * 4.5;
      mediumText2 = blockSizeHorizontal * 5.2;
      largeText1 = blockSizeHorizontal * 5.6;
      largeText2 = blockSizeHorizontal * 6.1;
      isTablet = false;
    }
  }
}
