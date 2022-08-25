import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mvc_flutter_app/utils/navigation/route_names.dart';
import 'package:mvc_flutter_app/utils/theme/dark_theme.dart';
import 'package:mvc_flutter_app/utils/theme/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Demo App',
      theme: LightTheme.light,
      themeMode: ThemeMode.light,
      darkTheme: DarkTheme.dark,
      initialRoute: RouteNames.splash,
      getPages: RouteNames.pages,
    );
  }
}
