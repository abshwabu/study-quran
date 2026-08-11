import 'package:drift/drift.dart';

@DataClassName('Root')
class Roots extends Table {
  IntColumn get rootId => integer()();
  TextColumn get rootArabic => text()();
  TextColumn get rootTranslit => text()();
  TextColumn get meaningsSummary => text().withDefault(const Constant(''))();
  IntColumn get occurrenceCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {rootId};
}

@DataClassName('Word')
class Words extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  IntColumn get position => integer()();
  TextColumn get arabicText => text()();
  TextColumn get transliteration => text()();
  TextColumn get translationGloss => text().withDefault(const Constant(''))();
  TextColumn get partOfSpeech => text().withDefault(const Constant(''))();
  TextColumn get grammarDetails => text().withDefault(const Constant(''))();
  IntColumn get rootId => integer().nullable().customConstraint('REFERENCES roots(root_id)')();
}
