import 'package:flutter/material.dart';
import 'package:flutter_pwd/common/constant/Constants.dart';

class RouteUtils {
  static void toMainPage(BuildContext context) {
    pushReplacementNamed(context, Routers.home);
  }

  static void pushReplacementNamed(BuildContext context, String pageName) {
    Navigator.of(context).pushReplacementNamed(pageName);
  }

  static Future<dynamic> push(BuildContext context, Widget page) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }
}
