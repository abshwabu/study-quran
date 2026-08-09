import 'package:drift/drift.dart';

@DataClassName('Surah')
class Surahs extends Table {
  IntColumn get number => integer()();
  TextColumn get nameArabic => text()();
  TextColumn get nameTranslit => text()();
  TextColumn get nameTranslation => text()();
  TextColumn get revelationPlace => text()();
  IntColumn get ayahCount => integer()();

  @override
  Set<Column> get primaryKey => {number};
}
