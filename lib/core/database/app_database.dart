import 'package:drift/drift.dart';
import 'tables/surahs.dart';
import 'tables/ayahs.dart';
import 'tables/translations.dart';
import 'tables/words_roots.dart';
import 'tables/content_packs.dart';
import 'tables/tafsir.dart';
import 'tables/thematic.dart';
import 'daos/quran_dao.dart';
import 'daos/search_dao.dart';
import 'daos/content_pack_dao.dart';
import 'daos/tafsir_dao.dart';
import 'daos/thematic_dao.dart';
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
    Topics,
    TopicAyahs,
    CrossReferences,
    AsbabAlNuzul,
  ],
  daos: [
    QuranDao,
    SearchDao,
    ContentPackDao,
    TafsirDao,
    ThematicDao,
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
        await customStatement('''
          CREATE TABLE IF NOT EXISTS tafsirs_meta (
            tafsir_id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            author TEXT NOT NULL,
            language TEXT NOT NULL,
            source TEXT NOT NULL,
            license_note TEXT NOT NULL
          );
        ''');
        await customStatement('''
          CREATE TABLE IF NOT EXISTS tafsir_content (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tafsir_id TEXT NOT NULL,
            surah_number INTEGER NOT NULL,
            start_ayah INTEGER NOT NULL,
            end_ayah INTEGER NOT NULL,
            text TEXT NOT NULL
          );
        ''');
        await customStatement('''
          CREATE TABLE IF NOT EXISTS topics (
            topic_id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            parent_topic_id TEXT,
            category TEXT NOT NULL DEFAULT 'General'
          );
        ''');
        await customStatement('''
          CREATE TABLE IF NOT EXISTS topic_ayahs (
            topic_id TEXT NOT NULL,
            surah_number INTEGER NOT NULL,
            ayah_number INTEGER NOT NULL,
            PRIMARY KEY (topic_id, surah_number, ayah_number)
          );
        ''');
        await customStatement('''
          CREATE TABLE IF NOT EXISTS cross_references (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            source_surah INTEGER NOT NULL,
            source_ayah INTEGER NOT NULL,
            target_surah INTEGER NOT NULL,
            target_ayah INTEGER NOT NULL,
            relationship_type TEXT NOT NULL,
            notes TEXT NOT NULL DEFAULT ''
          );
        ''');
        await customStatement('''
          CREATE TABLE IF NOT EXISTS asbab_al_nuzul (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            surah_number INTEGER NOT NULL,
            start_ayah INTEGER NOT NULL,
            end_ayah INTEGER NOT NULL,
            text_content TEXT NOT NULL,
            source_note TEXT NOT NULL
          );
        ''');
      },
    );
  }
}
