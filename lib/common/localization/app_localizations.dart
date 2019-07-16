import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Map<String, Map<String, Map<String, String>>> _localizedValues = {};

setLocalizedValues(Map<String, Map<String, Map<String, String>>> values) {
  _localizedValues = values;
}

class AppLocalizations {
  final Locale locale;

  static Iterable<Locale> supportedLocales = _getSupportedLocales();

  static List<Locale> _getSupportedLocales() {
    List<Locale> list = new List();
    _localizedValues.keys.forEach((value) {
      _localizedValues[value].keys.forEach((vv) {
        list.add(new Locale(value, vv));
      });
    });
    return list;
  }

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of(context, AppLocalizations);
  }

  String getSting(String id,
      {String languageCode, String countryCode, List<Object> params}) {
    String _languageCode = languageCode ?? locale.languageCode;
    String _countryCode = countryCode ?? locale.countryCode;
    Iterable<String> _keys = _localizedValues[_languageCode].keys;

    if (_countryCode == null ||
        _countryCode.isEmpty ||
        !_keys.contains(countryCode)) {
      _countryCode = _keys.toList()[0];
    }
    String value = _localizedValues[_languageCode][_countryCode][id];

    if (params != null && params.isNotEmpty) {
      for (int i = 0, length = params.length; i < length; i++) {
        value = value?.replaceAll('%\$$i\$s', '${params[i]}');
      }
    }

    return value;
  }

  ///全局静态的代理
  static LocalizationsDelegate delegate = new _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return _localizedValues.keys.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return new SynchronousFuture<AppLocalizations>(
        new AppLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
