import 'package:drift/drift.dart';

@DataClassName('TafsirMeta')
class TafsirsMeta extends Table {
  TextColumn get tafsirId => text()();
  TextColumn get name => text()();
  TextColumn get author => text()();
  TextColumn get language => text()();
  TextColumn get source => text()();
  TextColumn get licenseNote => text()();

  @override
  Set<Column> get primaryKey => {tafsirId};
}

@DataClassName('TafsirContentData')
class TafsirContent extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tafsirId => text()();
  IntColumn get surahNumber => integer()();
  IntColumn get startAyah => integer()();
  IntColumn get endAyah => integer()();
  TextColumn get textContent => text().named('text')();
}
