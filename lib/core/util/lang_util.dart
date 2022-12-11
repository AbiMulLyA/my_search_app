import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LangUtil {
  LangUtil(this.locale);

  final Locale locale;

  static LangUtil of(BuildContext context) {
    return Localizations.of<LangUtil>(context, LangUtil)!;
  }

  late Map<String, String> sentences;

  Future<bool> load() async {
    final String data =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    final Map<String, dynamic> _result =
        json.decode(data) as Map<String, dynamic>;

    sentences = <String, String>{};
    _result.forEach((String key, dynamic value) {
      sentences[key] = value.toString();
    });

    return true;
  }

  String trans(String key) {
    return sentences[key] ?? '';
  }
}

class LangUtilDelegate extends LocalizationsDelegate<LangUtil> {
  const LangUtilDelegate();

  @override
  bool isSupported(Locale locale) => ['id', 'en'].contains(locale.languageCode);

  @override
  Future<LangUtil> load(Locale locale) async {
    final LangUtil localizations = LangUtil(locale);
    await localizations.load();

    debugPrint("Load ${locale.languageCode} Lang");

    return localizations;
  }

  @override
  bool shouldReload(LangUtilDelegate old) => false;
}

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}
