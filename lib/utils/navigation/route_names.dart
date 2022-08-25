import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class RouteNames {
  static const String splash = "/";
  static const String auth = "/auth";
  static const String home = "/home";

  static final List<GetPage> _pages = [
    GetPage(name: splash, page: () => Container()),
    GetPage(name: auth, page: () => Container()),
    GetPage(name: home, page: () => Container()),
  ];

  static List<GetPage> get pages => [..._pages];
}
