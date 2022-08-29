import 'package:code_talks_demo/l10n/localization.dart';

class LocalizationDE implements Localization {
  @override String get push => 'So oft hast du den Knopf gedrückt:';
  @override String get add => 'Hinzufügen';
  @override String get type_todo => 'Füge einen Titel hinzu';
  @override String get type_descripion => 'Füge eine Beschreibung hinzu';
  @override String get add_todo => 'Füge dein Todo hinzu';
  @override String get done => 'Erledigt';
  @override String get undone => 'Zu erledigen';
  @override String get cancel => 'Abbrechen';
  @override String get delete => 'Löschen';
  @override String get edit => 'Ändern';
  @override String get send => 'Senden';
  @override String get okay => 'Okay';
  @override String get todo_added => 'Notiz hinzugefügt';
  @override String get todo_deleted => 'Notiz gelöscht';
  @override String get todo_checked => 'Notiz erledigt';
  @override String get todo_unchecked => 'Notiz aktiviert';
}