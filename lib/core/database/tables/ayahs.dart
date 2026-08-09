import 'package:drift/drift.dart';

@DataClassName('Ayah')
class Ayahs extends Table {
  IntColumn get globalAyahIndex => integer()();
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  TextColumn get arabicTextUthmani => text()();
  IntColumn get juz => integer()();
  IntColumn get page => integer()();

  @override
  Set<Column> get primaryKey => {globalAyahIndex};
}
