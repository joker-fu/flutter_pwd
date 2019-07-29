import 'package:flutter/material.dart';
import 'package:flutter_pwd/common/constant/Constants.dart';
import 'package:flutter_pwd/res/dimens.dart';
import 'package:flutter_pwd/res/strings.dart';
import 'package:flutter_pwd/ui/pages/main/me/gesture_password_page.dart';
import 'package:flutter_pwd/utils/app_utils.dart';
import 'package:flutter_pwd/utils/router_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SafeSettingPage extends StatefulWidget {
  @override
  _SafeSettingPageState createState() => _SafeSettingPageState();
}

class _SafeSettingPageState extends State<SafeSettingPage> {
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
              Expanded(child: Text(AppUtils.getString(context, id))),
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
    super.initState();
    _getGesturePassword();
  }

  Future _getGesturePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String gesturePassword = prefs.getString(PrefsKeys.gesturePassword);
    if (gesturePassword != null && gesturePassword != "") {
      setState(() {
        _useGesture = true;
      });
    }
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
            _renderItem(Icons.fingerprint, Ids.fingerprint, _useFinger,
                (value) {
              setState(() {
                _useFinger = value;
              });
            }),
            Divider(
              height: Dimens.dp1_2,
            ),
            _renderItem(Icons.apps, Ids.gesture, _useGesture, (value) {
              setState(() {
                _useGesture = value;
              });
              if (_useGesture) {
                _toGesturePasswordPage(context);
              }
            }),
          ],
        ),
      ),
    );
  }

  void _toGesturePasswordPage(BuildContext context) {
    RouteUtils.push(context, GesturePasswordPage()).then((value) async {
      if (value != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(PrefsKeys.gesturePassword, value);
      }
    });
  }
}
