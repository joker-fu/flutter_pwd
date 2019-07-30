import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_pwd/common/constant/Constants.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthHelper {
  LocalAuthentication _auth;

  LocalAuthHelper() {
    _auth = LocalAuthentication();
  }

  Future<dynamic> checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    return canCheckBiometrics;
  }

  Future<dynamic> getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = null;
      print(e);
    }
    return availableBiometrics;
  }

  Future<dynamic> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await _auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          androidAuthStrings: androidAuthStrings,
          iOSAuthStrings: iOSAuthStrings,
          stickyAuth: true);
    } on PlatformException catch (e) {
      authenticated = false;
      print(e);
    }
    return authenticated;
  }
}
