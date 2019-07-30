import 'package:flutter_pwd/common/constant/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsUtils {
  static Future<dynamic> setGesturePassword(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(PrefsKeys.gesturePassword, value);
  }

  static Future<String> getGesturePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrefsKeys.gesturePassword);
  }

  static void removeGesturePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(PrefsKeys.gesturePassword);
  }

  static Future<dynamic> setFingerPassword(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(PrefsKeys.fingerPassword, value);
  }

  static Future<bool> getFingerPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefsKeys.fingerPassword);
  }

  static void removeFingerPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(PrefsKeys.fingerPassword);
  }
}
