import 'package:flutter/material.dart';
import 'package:flutter_pwd/res/dimens.dart';
import 'package:flutter_pwd/res/strings.dart';
import 'package:flutter_pwd/ui/widget/common_dialog.dart';
import 'package:flutter_pwd/ui/widget/gesture/max_gesture_password.dart';
import 'package:flutter_pwd/utils/app_utils.dart';
import 'package:flutter_pwd/utils/local_auth_utils.dart';
import 'package:flutter_pwd/utils/prefs_utils.dart';
import 'package:flutter_pwd/utils/router_utils.dart';

class LoginPage extends StatefulWidget {
  final bool gPwd;
  final bool fPwd;

  LoginPage({
    Key key,
    @required this.gPwd,
    @required this.fPwd,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LocalAuthHelper authHelper = LocalAuthHelper();

  @override
  void initState() {
    if (widget.fPwd) {
      _authFinger();
    }
    super.initState();
  }

  void _authFinger() {
    authHelper.checkBiometrics().then((bool) {
      if (bool) {
        return authHelper.authenticate();
      }
      return true;
    }).then((success) {
      success
          ? RouteUtils.toMainPage(context)
          : CommonDialog.show(context, Text('验证失败！'));
    });
  }

  void _authGesture(String s) {
    PrefsUtils.getGesturePassword().then((pwd) {
      print('$s');
      if (pwd != null && pwd == s) {
        RouteUtils.toMainPage(context);
      } else {
        CommonDialog.show(context, Text('验证失败！'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(AppUtils.getString(context, Ids.pageNameLogin)),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              widget.gPwd
                      ? MaxGesturePassword(
                successCallback: (s) {
                  _authGesture(s);
                },
                failCallback: () {
                  CommonDialog.show(context, Text('验证失败！'));
                },
              )
                      : Container(),
              SizedBox(
                height: Dimens.dp20,
              ),
              widget.fPwd
                      ? Column(
                children: <Widget>[
                  IconButton(
                    iconSize: Dimens.dp40,
                    onPressed: () => _authFinger(),
                    icon: Icon(
                      Icons.fingerprint,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    '点击进行指纹解锁',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: Dimens.sp12,
                    ),
                  )
                ],
              )
                      : Container()
            ],
          ),
        ),
      ),
    );
  }
}
