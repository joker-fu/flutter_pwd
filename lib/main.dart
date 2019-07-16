import 'package:flutter/material.dart';
import 'package:flutter_pwd/res/Strings.dart';
import 'package:flutter_pwd/ui/pages/main/main_page.dart';
import 'package:flutter_pwd/ui/pages/splash/splash_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_pwd/common/constant/Constants.dart';
import 'package:flutter_pwd/utils/app_utils.dart';
import 'common/localization/app_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppUtils.getString(context, Ids.appName),
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
