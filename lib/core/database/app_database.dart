import 'package:drift/drift.dart';
import 'tables/surahs.dart';
import 'tables/ayahs.dart';
import 'tables/translations.dart';
import 'tables/words_roots.dart';
import 'tables/content_packs.dart';
import 'tables/tafsir.dart';
import 'tables/thematic.dart';
import 'tables/workspace.dart';
import 'tables/ai_history.dart';
import 'daos/quran_dao.dart';
import 'daos/search_dao.dart';
import 'daos/content_pack_dao.dart';
import 'daos/tafsir_dao.dart';
import 'daos/thematic_dao.dart';
import 'daos/workspace_dao.dart';
import 'daos/ai_history_dao.dart';
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
    Collections,
    Bookmarks,
    Notes,
    Tags,
    ItemTags,
    AiHistory,
  ],
  daos: [
    QuranDao,
    SearchDao,
    ContentPackDao,
    TafsirDao,
    ThematicDao,
    WorkspaceDao,
    AiHistoryDao,
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
        await customStatement('''
          CREATE TABLE IF NOT EXISTS collections (
            collection_id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT NOT NULL DEFAULT '',
            created_at INTEGER NOT NULL
          );
        ''');
        await customStatement('''
          CREATE TABLE IF NOT EXISTS bookmarks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            surah_number INTEGER NOT NULL,
            ayah_number INTEGER NOT NULL,
            collection_id TEXT,
            created_at INTEGER NOT NULL
          );
        ''');
        await customStatement('''
          CREATE TABLE IF NOT EXISTS notes (
            note_id TEXT PRIMARY KEY,
            surah_number INTEGER NOT NULL,
            start_ayah INTEGER NOT NULL,
            end_ayah INTEGER NOT NULL,
            text_content TEXT NOT NULL,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL
          );
        ''');
        await customStatement('''
          CREATE TABLE IF NOT EXISTS tags (
            tag_id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            color_hex TEXT NOT NULL DEFAULT '#009688'
          );
        ''');
        await customStatement('''
          CREATE TABLE IF NOT EXISTS item_tags (
            item_type TEXT NOT NULL,
            item_id TEXT NOT NULL,
            tag_id TEXT NOT NULL,
            PRIMARY KEY (item_type, item_id, tag_id)
          );
        ''');
        await customStatement('''
          CREATE TABLE IF NOT EXISTS ai_history (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            session_type TEXT NOT NULL,
            context_label TEXT NOT NULL,
            prompt_sent TEXT NOT NULL,
            response_received TEXT NOT NULL,
            created_at INTEGER NOT NULL
          );
        ''');

        // Seed default thematic topics, cross references, and asbab al-nuzul if surahs table is populated (real app mode)
        final surahCountRow = await customSelect('SELECT COUNT(*) AS c FROM surahs;').getSingle();
        final hasSurahs = surahCountRow.read<int>('c') > 0;

        if (hasSurahs) {
          final topicCount = await customSelect('SELECT COUNT(*) AS c FROM topics;').getSingle();
          if (topicCount.read<int>('c') == 0) {
            await customStatement('''
              INSERT INTO topics (topic_id, name, parent_topic_id, category) VALUES
              ('fiqh', 'Fiqh & Jurisprudence', NULL, 'Jurisprudence'),
              ('fiqh_salat', 'Prayer & Worship (Salah)', 'fiqh', 'Jurisprudence'),
              ('fiqh_zakat', 'Charity & Almsgiving (Zakat)', 'fiqh', 'Jurisprudence'),
              ('fiqh_sawm', 'Fasting & Ramadan (Sawm)', 'fiqh', 'Jurisprudence'),
              ('aqeedah', 'Creed & Theology (Aqeedah)', NULL, 'Theology'),
              ('aqeedah_tawheed', 'Monotheism & Oneness of Allah (Tawheed)', 'aqeedah', 'Theology'),
              ('aqeedah_prophets', 'Belief in Prophets & Messengers', 'aqeedah', 'Theology'),
              ('ethics', 'Morals & Character (Akhlaq)', NULL, 'Ethics'),
              ('ethics_patience', 'Patience & Perseverance (Sabr)', 'ethics', 'Ethics'),
              ('ethics_gratitude', 'Gratitude & Thankfulness (Shukr)', 'ethics', 'Ethics'),
              ('eschatology', 'The Hereafter & Day of Judgment', NULL, 'Eschatology'),
              ('day_of_judgment', 'Day of Judgment (Yawm al-Qiyamah)', 'eschatology', 'Eschatology'),
              ('jannah', 'Paradise & Eternal Rewards (Jannah)', 'eschatology', 'Eschatology');
            ''');

            await customStatement('''
              INSERT INTO topic_ayahs (topic_id, surah_number, ayah_number) VALUES
              ('fiqh_salat', 1, 2),
              ('fiqh_salat', 1, 5),
              ('fiqh_salat', 1, 6),
              ('fiqh_salat', 1, 7),
              ('fiqh_zakat', 1, 2),
              ('fiqh_zakat', 1, 5),
              ('aqeedah_tawheed', 1, 1),
              ('aqeedah_tawheed', 1, 2),
              ('aqeedah_tawheed', 1, 5),
              ('ethics_patience', 1, 5),
              ('ethics_patience', 1, 6),
              ('ethics_gratitude', 1, 2),
              ('day_of_judgment', 1, 4),
              ('jannah', 1, 6),
              ('jannah', 1, 7);
            ''');
          }

          final crossCount = await customSelect('SELECT COUNT(*) AS c FROM cross_references;').getSingle();
          if (crossCount.read<int>('c') == 0) {
            await customStatement('''
              INSERT INTO cross_references (source_surah, source_ayah, target_surah, target_ayah, relationship_type, notes) VALUES
              (1, 2, 1, 5, 'Similar Theme: Praise & Worship', 'Direct thematic connection'),
              (1, 5, 1, 6, 'Sequential Exhortation: Seeking Guidance', 'Dua for the Straight Path');
            ''');
          }

          final asbabCount = await customSelect('SELECT COUNT(*) AS c FROM asbab_al_nuzul;').getSingle();
          if (asbabCount.read<int>('c') == 0) {
            await customStatement('''
              INSERT INTO asbab_al_nuzul (surah_number, start_ayah, end_ayah, text_content, source_note) VALUES
              (1, 1, 7, 'Surah Al-Fatihah was revealed in Makkah as the comprehensive opening of the Quran, taught by Jibreel (AS) to Prophet Muhammad (ﷺ).', 'Asbab al-Nuzul by Al-Wahidi');
            ''');
          }
        }
      },


    );
  }
}
