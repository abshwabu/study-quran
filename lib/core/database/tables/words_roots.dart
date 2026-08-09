import 'package:drift/drift.dart';

@DataClassName('Root')
class Roots extends Table {
  IntColumn get rootId => integer()();
  TextColumn get rootArabic => text()();
  TextColumn get rootTranslit => text()();

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
  IntColumn get rootId => integer().nullable().customConstraint('REFERENCES roots(root_id)')();

}
