import 'package:flutter/material.dart';
import 'package:flutter_pwd/res/dimens.dart';
import 'package:flutter_pwd/ui/widget/gesture/max_gesture_password.dart';
import 'package:flutter_pwd/ui/widget/gesture/min_gesture_password.dart';
import 'package:flutter_pwd/utils/prefs_utils.dart';

class GesturePasswordPage extends StatefulWidget {
  static const ACTION_CHECK_GESTURE_PWD = 0;
  static const ACTION_SETTING_GESTURE_PWD = 1;
  static const ACTION_CANCEL_GESTURE_PWD = 2;

  final int action;

  GesturePasswordPage({Key key, @required this.action}) : super(key: key);

  @override
  _GesturePasswordPageState createState() => _GesturePasswordPageState();
}

class _GesturePasswordPageState extends State<GesturePasswordPage> {
  GlobalKey<MiniGesturePasswordState> miniGesturePassword = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  String _tips = "";
  String _gesturePassword;

  @override
  void initState() {
    switch (widget.action) {
      case GesturePasswordPage.ACTION_CHECK_GESTURE_PWD:
        _tips = "验证手势密码";
        break;
      case GesturePasswordPage.ACTION_SETTING_GESTURE_PWD:
        _tips = "绘制解锁图案"; //再次绘制解锁图案
        break;
      case GesturePasswordPage.ACTION_CANCEL_GESTURE_PWD:
        _tips = "请绘制原解锁图案";
        break;
      default:
        break;
    }
    PrefsUtils.getGesturePassword().then((pwd) {
      _gesturePassword = pwd;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text('手势密码'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: Dimens.dp20,
          ),
          Center(child: MiniGesturePassword(key: miniGesturePassword)),
          SizedBox(
            height: Dimens.dp20,
          ),
          Text(_tips),
          Container(
            margin: const EdgeInsets.only(top: Dimens.dp50),
            child: MaxGesturePassword(
              successCallback: (s) {
                Widget contentWidget;
                switch (widget.action) {
                  case GesturePasswordPage.ACTION_SETTING_GESTURE_PWD:
                    if (_gesturePassword == s) {
                      contentWidget = Text('设置成功');
                      Navigator.of(context).pop(_gesturePassword);
                    } else if (_gesturePassword == null) {
                      contentWidget = Text('请再次确认手势');
                      _gesturePassword = s;
                      setState(() {
                        _tips = "再次绘制解锁图案";
                      });
                    } else {
                      contentWidget = Text('与上次绘制不一致，请重新绘制');
                    }
                    break;
                  case GesturePasswordPage.ACTION_CHECK_GESTURE_PWD:
                  case GesturePasswordPage.ACTION_CANCEL_GESTURE_PWD:
                    if (_gesturePassword == s) {
                      if (widget.action ==
                          GesturePasswordPage.ACTION_CANCEL_GESTURE_PWD) {
                        PrefsUtils.removeGesturePassword();
                      }
                      Navigator.of(context).pop();
                    } else {
                      contentWidget = Text('手势错误');
                    }
                    miniGesturePassword.currentState?.setSelected('');
                    break;
                  default:
                    break;
                }
//                if (_gesturePassword == s) {
//                  contentWidget = Text('设置成功');
//                  Navigator.of(context).pop(_gesturePassword);
//                } else if (_gesturePassword == null) {
//                  contentWidget = Text('请再次确认手势');
//                  _gesturePassword = s;
//                } else {
//                  contentWidget = Text('与上次绘制不一致，请重新绘制');
//                }
                scaffoldState.currentState?.showSnackBar(SnackBar(
                  content: contentWidget,
                ));
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
