import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppImages {
  static const String _imageDirectory = "assets/images";
  static const String _fontsDirectory = "assets/fonts";
  static const String _jsonDirectory = "assets/json";

  //---------------- Images--------------------
  //---------------- Fonts--------------------
  //---------------- Json--------------------
}

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;

    //--------- Use for spacing or container etc for responsive.-------------------
    _safeAreaHorizontal =
        _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical =
        _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;

    //------- USE FOR FONT SIZES FOR RESPONSIVE-----------
    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;
  }
}

class AppUtils {
  static const kDivider = Divider();

  static const kPaddingAllSides = EdgeInsets.all(8.0);
}

class AppAlerts {
  static void successSnackBar(
      {required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green.shade800,
      colorText: Colors.white,
    );
  }

  static void errorSnackBar({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red.shade800,
      colorText: Colors.white,
    );
  }
}
