import 'package:flutter/material.dart';
import 'package:flutter_pwd/res/dimens.dart';
import 'package:flutter_pwd/res/strings.dart';
import 'package:flutter_pwd/ui/pages/main/me/gesture_password_page.dart';
import 'package:flutter_pwd/utils/app_utils.dart';
import 'package:flutter_pwd/utils/local_auth_utils.dart';
import 'package:flutter_pwd/utils/prefs_utils.dart';
import 'package:flutter_pwd/utils/router_utils.dart';

class SafeSettingPage extends StatefulWidget {
  @override
  _SafeSettingPageState createState() => _SafeSettingPageState();
}

class _SafeSettingPageState extends State<SafeSettingPage> {
  final LocalAuthHelper authHelper = LocalAuthHelper();
  bool _authCanUse = false;
  bool _useFinger = false;
  bool _useGesture = false;

  Widget _renderItem(
      IconData icon, String id, bool status, ValueChanged<bool> onChanged) {
    return Container(
      color: Colors.white,
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Dimens.dp12,
            horizontal: Dimens.dp16,
          ),
          child: Row(
            children: <Widget>[
              Icon(icon),
              SizedBox(
                width: Dimens.dp10,
              ),
              Expanded(
                child: Text(AppUtils.getString(context, id)),
              ),
              Switch(
                value: status,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    PrefsUtils.getGesturePassword().then((pwd) {
      if (pwd != null && pwd != "") {
        setState(() {
          _useGesture = true;
        });
      }
    });
    PrefsUtils.getFingerPassword().then((pwd) {
      setState(() {
        if (pwd != null) {
          _useFinger = pwd;
        }
      });
    });
    authHelper.checkBiometrics().then((bool) {
      _authCanUse = bool;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('安全设置'),
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: Dimens.dp10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Dimens.dp12,
                horizontal: Dimens.dp16,
              ),
              child: Text(AppUtils.getString(context, Ids.setUnlockMethod)),
            ),
            _renderItem(Icons.fingerprint, Ids.fingerprint, _useFinger, (v) {
              if (_authCanUse) {
                _toAuthFinger(context, v);
              } else {
                print('指纹不能使用！');
              }
            }),
            Divider(
              height: Dimens.dp1_2,
            ),
            _renderItem(Icons.apps, Ids.gesture, _useGesture, (v) {
              _toGesturePasswordPage(context, v);
            }),
          ],
        ),
      ),
    );
  }

  //验证指纹
  void _toAuthFinger(BuildContext context, bool value) {
    authHelper.authenticate().then((v) {
      if (v) {
        setState(() {
          _useFinger = value;
          PrefsUtils.setFingerPassword(value);
        });
      }
    });
  }

  //跳转手势密码页
  void _toGesturePasswordPage(BuildContext context, bool value) {
    int action = value
        ? GesturePasswordPage.ACTION_SETTING_GESTURE_PWD
        : GesturePasswordPage.ACTION_CANCEL_GESTURE_PWD;

    RouteUtils.push(
      context,
      GesturePasswordPage(action: action),
    ).then((value) async {
      if (value != null) {
        PrefsUtils.setGesturePassword(value);
        setState(() {
          _useGesture = value != null;
        });
      }
    });
  }
}
