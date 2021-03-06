import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pwd/res/strings.dart';
import 'package:flutter_pwd/ui/pages/main/main_page.dart';
import 'package:flutter_pwd/ui/pages/splash/splash_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_pwd/common/constant/Constants.dart';
import 'package:flutter_pwd/utils/app_utils.dart';
import 'common/localization/app_localizations.dart';

void main() {
  // flutter 版本升级至v1.12.13+hotfix.5后，在runApp()之前调用，否则启动App会白屏
  WidgetsFlutterBinding.ensureInitialized();
  //去掉状态栏透明层
  if (Platform.isAndroid) {
    var style = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
  // 限制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  @override
  void initState() {
    super.initState();
    setLocalizedValues(localizedValues);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppUtils.getString(context, Ids.appName),
      routes: {Routers.home: (ctx) => MainPage()},
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      locale: _locale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizations.delegate
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
