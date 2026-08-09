import 'package:drift/drift.dart';

@DataClassName('TranslationMeta')
class TranslationsMeta extends Table {
  TextColumn get translationId => text()();
  TextColumn get language => text()();
  TextColumn get translatorName => text()();
  TextColumn get source => text()();
  TextColumn get licenseNote => text()();

  @override
  Set<Column> get primaryKey => {translationId};
}

@DataClassName('AyahTranslation')
class AyahTranslations extends Table {
  TextColumn get translationId => text()();
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  TextColumn get textContent => text().named('text')();

  @override
  Set<Column> get primaryKey => {translationId, surahNumber, ayahNumber};
}
