import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pwd/common/constant/Constants.dart';
import 'package:flutter_pwd/ui/widget/common_dialog.dart';
import 'package:flutter_pwd/utils/router_utils.dart';
import 'package:local_auth/local_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
      print('************$canCheckBiometrics');
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
      print('************$availableBiometrics');
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          androidAuthStrings: androidAuthStrings,
          iOSAuthStrings: iOSAuthStrings,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _authorized = authenticated ? 'Authorized' : 'Not Authorized';
      print('************$authenticated');
      authenticated
          ? RouteUtils.toMainPage(context)
          : CommonDialog.show(context, Text('验证失败！'));
    });
  }

  void _initAsync() async {
//    Observable.timer(0, Duration(seconds: 3)).listen((data) {
//      print('---------------------$data');
//      RouteUtils.toMainPage(context);
//    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String gesturePassword = prefs.getString(PrefsKeys.gesturePassword);
    print('------------------------->  $gesturePassword');
  }

  @override
  void initState() {
    super.initState();
    _initAsync();
    _checkBiometrics();
    _getAvailableBiometrics();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Center(
      child: Text("Splash Page"),
    ));
  }
}
