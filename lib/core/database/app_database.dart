import 'package:drift/drift.dart';
import 'tables/surahs.dart';
import 'tables/ayahs.dart';
import 'tables/translations.dart';
import 'tables/words_roots.dart';
import 'tables/content_packs.dart';
import 'tables/tafsir.dart';
import 'daos/quran_dao.dart';
import 'daos/search_dao.dart';
import 'daos/content_pack_dao.dart';
import 'daos/tafsir_dao.dart';
import 'fts_setup.dart';
import 'connection.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Surahs,
    Ayahs,
    TranslationsMeta,
    AyahTranslations,
    Words,
    Roots,
    ContentPacks,
    TafsirsMeta,
    TafsirContent,
  ],
  daos: [
    QuranDao,
    SearchDao,
    ContentPackDao,
    TafsirDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        try {
          await m.createAll();
          await FtsSetup.createCoreFtsTables(executor);
        } catch (e) {
          // Pre-populated core_bundle.db already contains schema tables
        }
      },
      onUpgrade: (m, from, to) async {
        // Step-by-step migrations hook for Prompts 02 - 09
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON;');
      },
    );
  }
}
