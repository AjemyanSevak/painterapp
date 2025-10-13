import 'dart:io';

import 'package:flutter/material.dart';

final _window = WidgetsBinding.instance.platformDispatcher.views.first;

final devicePixelRatio = _window.devicePixelRatio;
final screenWidth = _window.physicalSize.shortestSide / devicePixelRatio;
final screenHeight = _window.physicalSize.longestSide / devicePixelRatio;
final safeAreaTop = _window.padding.top / devicePixelRatio;
final safeAreaBottom = _window.padding.bottom / devicePixelRatio;

const kAppBarHeight = 56.0;
const kButtonHeight = 56.0;
const kTextFieldHeight = 56.0;
const kRadioButtonSize = 18.0;
const kDialogIconSize = 32.0;
const kHorizontalPadding = 24.0;
const kVerticalPadding = 32.0;

void printWrapped(String text) {
  // ignore: avoid_print
  RegExp('.{1,800}').allMatches(text).map((m) => m.group(0)).forEach(print);
}

List<Locale> get supportedLocales => [const Locale('en'), const Locale('ru')];

Locale get deviceLocale {
  final deviceLocale = Platform.localeName.split('_').first;
  var initialLocale = const Locale('en');

  if (supportedLocales.map((e) => e.languageCode).contains(deviceLocale)) {
    initialLocale = Locale(deviceLocale);
  }

  return initialLocale;
}
