import 'package:flutter/material.dart';
import 'package:flutter_pwd/res/dimens.dart';
import 'package:flutter_pwd/res/strings.dart';
import 'package:flutter_pwd/ui/widget/common_dialog.dart';
import 'package:flutter_pwd/utils/app_utils.dart';
import 'package:flutter_pwd/utils/local_auth_utils.dart';
import 'package:flutter_pwd/utils/router_utils.dart';

class LoginPage extends StatelessWidget {
  final LocalAuthHelper authHelper = LocalAuthHelper();
  final bool gPwd;
  final bool fPwd;

  LoginPage({Key key, @required this.gPwd, @required this.fPwd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(AppUtils.getString(context, Ids.pageNameLogin)),
      ),
      body: Container(
        padding: EdgeInsets.all(Dimens.dp16),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('手势控件'),
              IconButton(
                icon: Icon(Icons.fingerprint),
              )
            ],
          ),
        ),
      ),
    );
  }
}
