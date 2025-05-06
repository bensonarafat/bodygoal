import 'package:bodygoal/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/find_locale.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocaleLogic {
  final Locale _defaultLocal = const Locale('en');

  AppLocalizations? _strings;
  AppLocalizations get strings => _strings!;
  bool get isLoaded => _strings != null;
  bool get isEnglish => strings.localeName == 'en';

  Future<void> load() async {
    Locale locale = _defaultLocal;
    final localCode =
        settingsLogic.currentLocale.value ?? await findSystemLocale();
    locale = Locale(localCode.split("_")[0]);

    if (AppLocalizations.supportedLocales.contains(locale) == false) {
      locale = _defaultLocal;
    }

    settingsLogic.currentLocale.value = locale.languageCode;
    _strings = await AppLocalizations.delegate.load(locale);
  }

  Future<void> loadIfChanged(Locale locale) async {
    bool didChange = _strings?.localeName != locale.languageCode;
    if (didChange && AppLocalizations.supportedLocales.contains(locale)) {
      _strings = await AppLocalizations.delegate.load(locale);
    }
  }
}
