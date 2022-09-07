import 'package:code_talks_demo/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/localization.dart';
import 'resources/lib.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeTalks',
      theme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: ColorHelper.getValue(BrandColor.blue),
        primaryColor: ColorHelper.getValue(BrandColor.lila),
        errorColor: ColorHelper.getValue(BrandColor.red),
        highlightColor: ColorHelper.getValue(BrandColor.orange),
        hintColor: Colors.black26,
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
      home: const MyTodoPage(title: 'Code.Talks Demo'),
    );
  }
}
