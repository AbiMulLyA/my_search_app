import 'package:flutter/material.dart';

enum LangType {
  id,
  en,
}

final Map<LangType, Locale> mySearchLang = {
  LangType.id: const Locale('id', 'ID'),
  LangType.en: const Locale('en', 'US'),
};
