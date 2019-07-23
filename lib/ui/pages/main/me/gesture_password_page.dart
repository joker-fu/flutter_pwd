import 'package:flutter/material.dart';
import 'package:flutter_pwd/ui/widget/gesture/max_gesture_password.dart';
import 'package:flutter_pwd/ui/widget/gesture/min_gesture_password.dart';

class GesturePasswordPage extends StatefulWidget {
  @override
  _GesturePasswordPageState createState() => _GesturePasswordPageState();
}

class _GesturePasswordPageState extends State<GesturePasswordPage> {
  GlobalKey<MiniGesturePasswordState> miniGesturePassword = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text('Plugin example app'),
      ),
      body: Column(
        children: <Widget>[
          Center(child: MiniGesturePassword(key: miniGesturePassword)),
          Container(
            margin: const EdgeInsets.only(top: 100.0),
            child: MaxGesturePassword(
              successCallback: (s) {
                print("successCallback$s");
                scaffoldState.currentState?.showSnackBar(SnackBar(
                  content: Text('successCallback:$s'),
                ));
                miniGesturePassword.currentState?.setSelected('');
              },
              failCallback: () {
                print('failCallback');
                scaffoldState.currentState?.showSnackBar(SnackBar(
                  content: Text('failCallback'),
                ));
                miniGesturePassword.currentState?.setSelected('');
              },
              selectedCallback: (str) {
                miniGesturePassword.currentState?.setSelected(str);
              },
            ),
          )
        ],
      ),
    );
  }
}
