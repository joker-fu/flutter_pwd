import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pwd/ui/pages/login/login_page.dart';
import 'package:flutter_pwd/utils/prefs_utils.dart';
import 'package:flutter_pwd/utils/router_utils.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _gPwd = false;
  bool _fPwd = false;
  Timer _timer;

  Future _initAsync() async {
//    Observable.timer(0, Duration(seconds: 3)).listen((data) {
//      print('---------------------$data');
//      RouteUtils.toMainPage(context);
//    });
    _gPwd = await PrefsUtils.getGesturePassword().then((pwd) {
      return pwd != null && pwd != "";
    });
    _fPwd = await PrefsUtils.getFingerPassword().then((pwd) {
      return pwd != null && pwd;
    });
  }

  @override
  void initState() {
    _initAsync().then((_) {
      _timer = Timer(Duration(seconds: 3), () {
        if (!_gPwd && !_fPwd) {
          RouteUtils.toMainPage(context);
        } else {
          RouteUtils.pushAndRemove(context, LoginPage(gPwd: _gPwd, fPwd: _fPwd));
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text("Splash Page"),
      ),
    );
  }
}
