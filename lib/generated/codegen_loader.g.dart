// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> kk = {
  "search_hint": "Іздеу",
  "btm_nav_home": "Басты бет",
  "btm_nav_favourites": "Қазақша",
  "btm_nav_history": "Тарих",
  "btm_nav_profile": "Профиль"
};
static const Map<String,dynamic> ru = {
  "search_hint": "Поиск",
  "btm_nav_home": "Главная",
  "btm_nav_favourites": "Избранное",
  "btm_nav_history": "История",
  "btm_nav_profile": "Профиль"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"kk": kk, "ru": ru};
}
