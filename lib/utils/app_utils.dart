import 'package:flutter/material.dart';
import 'package:flutter_pwd/common/localization/app_localizations.dart';

class AppUtils {
  //获取字符串
  static String getString(BuildContext context, String id,
      {String languageCode, String countryCode, List<Object> params}) {
    return AppLocalizations.of(context).getSting(id,
        languageCode: languageCode, countryCode: countryCode, params: params);
  }
}
