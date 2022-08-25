import 'package:get/get.dart';

class _BasicAppRoute {
  //This method will maintain the back stack of screens.args are arguments to pass to second screen if provided only.
  static void navigateToNewScreen(String routeName, {dynamic args}) {
    if (args != null) {
      Get.toNamed(
        routeName,
        arguments: args,
      );
    }

    Get.toNamed(routeName);
  }

//This method will replace/remove all the backstack and push a new screen to stack.
  static void replaceToNewScreen(String routeName) {
    Get.offAllNamed(
      routeName,
    );
  }

  static void removeCurrentAndReplaceToNewScreen(String routeName) {
    Get.offNamed(
      routeName,
    );
  }
}

class AppNavigations {
  //navigate Back

  static navigateBack() {
    Get.back();
  }
//------------------ AUTH ROUTES----------------------

}
