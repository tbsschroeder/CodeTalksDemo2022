import 'package:code_talks_demo/l10n/localization.dart';

class LocalizationEN implements Localization {
  @override String get push => 'You have pushed the button this many times:';
  @override String get add => 'Add';
  @override String get type_todo => 'Your title';
  @override String get type_descripion => 'Your description';
  @override String get add_todo => 'Add a new todo item';
  @override String get done => 'Done';
  @override String get undone => 'Todo';
  @override String get cancel => 'Cancel';
  @override String get delete => 'Delete';
  @override String get edit => 'Edit';
  @override String get send => 'Send';
  @override String get okay => 'Okay';
  @override String get todo_added => 'Note added';
  @override String get todo_deleted => 'Note deleted';
  @override String get todo_checked => 'Note checked';
  @override String get todo_unchecked => 'Note unchecked';
}