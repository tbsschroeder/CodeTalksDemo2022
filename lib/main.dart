import 'package:code_talks_demo/todo.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/localization.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeTalks',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
        typography: Typography.material2021(),
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        CodeTalksDemoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('de'),
      ],
      home: const MyTodoPage(),
    );
  }
}
