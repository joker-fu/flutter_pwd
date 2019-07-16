import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_pwd/utils/router_utils.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  void _initAsync() {
    Observable.timer(0, Duration(seconds: 3)).listen((data) {
      print('---------------------$data');
      RouteUtils.toMainPage(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Center(
      child: Text("Splash Page"),
    ));
  }
}
