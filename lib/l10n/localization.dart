import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:code_talks_demo/l10n/localization_de.dart';
import 'package:code_talks_demo/l10n/localization_en.dart';

abstract class Localization {
  static Localization? of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  String get push;
  String get add;
  String get type_todo;
  String get type_descripion;
  String get add_todo;
  String get done;
  String get undone;
  String get cancel;
  String get delete;
  String get edit;
  String get send;
  String get okay;
  String get todo_added;
  String get todo_deleted;
  String get todo_checked;
  String get todo_unchecked;
}

class CodeTalksDemoLocalizationsDelegate extends LocalizationsDelegate<Localization> {
  const CodeTalksDemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'de'].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) => _load(locale);

  static Future<Localization> _load(Locale locale) async {
    final String name = (locale.countryCode == null || locale.countryCode!.isEmpty) ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    Intl.defaultLocale = localeName;

    if( locale.languageCode == 'en' ) {
      return LocalizationEN();
    }
      return LocalizationDE();
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => false;
}