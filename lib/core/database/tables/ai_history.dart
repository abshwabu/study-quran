import 'package:drift/drift.dart';

@DataClassName('AiHistoryEntry')
class AiHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sessionType => text()(); // 'explain', 'compare_tafsir', 'summary'
  TextColumn get contextLabel => text()(); // e.g. "Surah Al-Fatihah (1:1)"
  TextColumn get promptSent => text()();
  TextColumn get responseReceived => text()();
  DateTimeColumn get createdAt => dateTime()();
}
