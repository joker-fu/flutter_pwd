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

  String _gesturePassword;

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
                Widget contentWidget;
                if (_gesturePassword == s) {
                  contentWidget = Text('设置成功');
                  Navigator.of(context).pop(_gesturePassword);
                } else if (_gesturePassword == null) {
                  contentWidget = Text('请再次确认手势');
                  _gesturePassword = s;
                } else {
                  contentWidget = Text('与上次绘制不一致，请重新绘制');
                }
                scaffoldState.currentState?.showSnackBar(SnackBar(
                  content: contentWidget,
                ));
                miniGesturePassword.currentState?.setSelected('');
              },
              failCallback: () {
                scaffoldState.currentState?.showSnackBar(SnackBar(
                  content: Text('至少绘制4个点'),
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
