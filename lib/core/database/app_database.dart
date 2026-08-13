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
          if (topicCount.read<int>('c') < 30) {
            // Delete old minimal seed if upgrading
            await customStatement('DELETE FROM topics;');
            await customStatement('DELETE FROM topic_ayahs;');

            await customStatement('''
              INSERT INTO topics (topic_id, name, parent_topic_id, category) VALUES
              -- 1. Creed & Theology (Aqeedah)
              ('aqeedah', 'Creed & Theology (Aqeedah)', NULL, 'Theology'),
              ('aqeedah_tawheed', 'Monotheism & Oneness of Allah (Tawheed)', 'aqeedah', 'Theology'),
              ('aqeedah_names', 'Divine Names & Attributes of Allah', 'aqeedah', 'Theology'),
              ('aqeedah_prophets', 'Belief in Prophets & Messengers', 'aqeedah', 'Theology'),
              ('aqeedah_angels', 'Belief in Angels (Malaikah)', 'aqeedah', 'Theology'),
              ('aqeedah_books', 'Revealed Scriptures & Holy Books', 'aqeedah', 'Theology'),
              ('aqeedah_qadar', 'Divine Decree & Destiny (Al-Qadar)', 'aqeedah', 'Theology'),

              -- 2. Worship & Fiqh (Ibadah)
              ('fiqh', 'Worship & Jurisprudence (Fiqh)', NULL, 'Jurisprudence'),
              ('fiqh_salat', 'Prayer & Worship (Salah)', 'fiqh', 'Jurisprudence'),
              ('fiqh_zakat', 'Charity & Obligatory Almsgiving (Zakat)', 'fiqh', 'Jurisprudence'),
              ('fiqh_sawm', 'Fasting & Ramadan (Sawm)', 'fiqh', 'Jurisprudence'),
              ('fiqh_hajj', 'Pilgrimage to Makkah (Hajj & Umrah)', 'fiqh', 'Jurisprudence'),
              ('fiqh_dua', 'Supplication & Calling upon Allah (Dua)', 'fiqh', 'Jurisprudence'),
              ('fiqh_dhikr', 'Remembrance & Glorification (Dhikr)', 'fiqh', 'Jurisprudence'),
              ('fiqh_taharah', 'Purification & Ablution (Wudu & Ghusl)', 'fiqh', 'Jurisprudence'),

              -- 3. Morals & Ethics (Akhlaq)
              ('ethics', 'Morals, Ethics & Character (Akhlaq)', NULL, 'Ethics'),
              ('ethics_patience', 'Patience & Perseverance (Sabr)', 'ethics', 'Ethics'),
              ('ethics_gratitude', 'Gratitude & Thankfulness (Shukr)', 'ethics', 'Ethics'),
              ('ethics_truthfulness', 'Honesty & Truthfulness (Sidq)', 'ethics', 'Ethics'),
              ('ethics_forgiveness', 'Forgiveness & Pardoning Others', 'ethics', 'Ethics'),
              ('ethics_humility', 'Humility & Avoiding Arrogance', 'ethics', 'Ethics'),
              ('ethics_trust', 'Trustworthiness & Fulfilling Pledges', 'ethics', 'Ethics'),
              ('ethics_kindness_parents', 'Kindness to Parents (Birr al-Walidayn)', 'ethics', 'Ethics'),

              -- 4. Social Life & Justice (Muamalat)
              ('social', 'Social Life & Family Justice (Muamalat)', NULL, 'Social Justice'),
              ('social_justice', 'Justice & Absolute Equity (Adl)', 'social', 'Social Justice'),
              ('social_marriage', 'Marriage & Spousal Harmony (Nikah)', 'social', 'Social Justice'),
              ('social_orphans', 'Care for Orphans & Vulnerable', 'social', 'Social Justice'),
              ('social_trade', 'Halal Commerce & Financial Integrity', 'social', 'Social Justice'),
              ('social_prohibition_usury', 'Prohibition of Riba (Usury/Interest)', 'social', 'Social Justice'),

              -- 5. Stories of the Prophets (Qasas al-Anbiya)
              ('stories', 'Stories of the Prophets (Qasas al-Anbiya)', NULL, 'Prophet Narratives'),
              ('story_adam', 'Prophet Adam (AS) & Creation of Humanity', 'stories', 'Prophet Narratives'),
              ('story_nuh', 'Prophet Noah (Nuh AS) & The Great Flood', 'stories', 'Prophet Narratives'),
              ('story_ibrahim', 'Prophet Abraham (Ibrahim AS) - Patriarch', 'stories', 'Prophet Narratives'),
              ('story_musa', 'Prophet Moses (Musa AS) & Pharaoh', 'stories', 'Prophet Narratives'),
              ('story_yusuf', 'Prophet Joseph (Yusuf AS) - The Best Narrative', 'stories', 'Prophet Narratives'),
              ('story_isa', 'Prophet Jesus (Isa AS) & Maryam (RA)', 'stories', 'Prophet Narratives'),
              ('story_muhammad', 'Prophet Muhammad (ﷺ) - Seal of Prophets', 'stories', 'Prophet Narratives'),

              -- 6. Eschatology & The Unseen
              ('eschatology', 'Eschatology, Death & The Unseen', NULL, 'Eschatology'),
              ('day_of_judgment', 'Day of Judgment (Yawm al-Qiyamah)', 'eschatology', 'Eschatology'),
              ('jannah', 'Paradise & Eternal Rewards (Jannah)', 'eschatology', 'Eschatology'),
              ('jahannam', 'Hellfire & Warning (Jahannam)', 'eschatology', 'Eschatology'),

              -- 7. Creation & Cosmology (Kauniyat)
              ('nature', 'Creation, Science & Nature (Kauniyat)', NULL, 'Cosmology'),
              ('nature_creation', 'Creation of Heavens & Earth', 'nature', 'Cosmology'),
              ('nature_astronomy', 'Sun, Moon, Stars & Celestial Orbits', 'nature', 'Cosmology'),
              ('nature_water', 'Rain, Oceans & Cycle of Life', 'nature', 'Cosmology'),
              ('nature_human_creation', 'Embryology & Development of Man', 'nature', 'Cosmology'),

              -- 8. Trials, Relief & Comfort (Faraj)
              ('comfort', 'Trials, Relief & Spiritual Healing', NULL, 'Spiritual Healing'),
              ('comfort_hope', 'Allah''s Infinite Mercy & Forgiveness', 'comfort', 'Spiritual Healing'),
              ('comfort_tawakkul', 'Reliance & Complete Trust in Allah', 'comfort', 'Spiritual Healing'),
              ('comfort_istighfar', 'Seeking Repentance & Istighfar', 'comfort', 'Spiritual Healing'),
              ('comfort_relief', 'Ease & Relief After Hardship (Faraj)', 'comfort', 'Spiritual Healing');
            ''');

            await customStatement('''
              INSERT INTO topic_ayahs (topic_id, surah_number, ayah_number) VALUES
              -- Aqeedah Tawheed
              ('aqeedah_tawheed', 1, 1), ('aqeedah_tawheed', 1, 2), ('aqeedah_tawheed', 1, 5),
              ('aqeedah_tawheed', 2, 255), ('aqeedah_tawheed', 6, 102), ('aqeedah_tawheed', 112, 1),
              ('aqeedah_tawheed', 112, 2), ('aqeedah_tawheed', 112, 3), ('aqeedah_tawheed', 112, 4),
              -- Divine Names
              ('aqeedah_names', 2, 255), ('aqeedah_names', 7, 180), ('aqeedah_names', 20, 8),
              ('aqeedah_names', 59, 22), ('aqeedah_names', 59, 23), ('aqeedah_names', 59, 24),
              -- Prophets
              ('aqeedah_prophets', 2, 136), ('aqeedah_prophets', 2, 285), ('aqeedah_prophets', 4, 163),
              ('aqeedah_prophets', 6, 84), ('aqeedah_prophets', 21, 107),
              -- Fiqh Salat
              ('fiqh_salat', 1, 2), ('fiqh_salat', 1, 5), ('fiqh_salat', 1, 6), ('fiqh_salat', 1, 7),
              ('fiqh_salat', 2, 3), ('fiqh_salat', 2, 43), ('fiqh_salat', 2, 45), ('fiqh_salat', 2, 110),
              ('fiqh_salat', 2, 153), ('fiqh_salat', 2, 238), ('fiqh_salat', 17, 78), ('fiqh_salat', 20, 14),
              -- Fiqh Zakat
              ('fiqh_zakat', 2, 43), ('fiqh_zakat', 2, 110), ('fiqh_zakat', 2, 177), ('fiqh_zakat', 2, 261),
              ('fiqh_zakat', 2, 267), ('fiqh_zakat', 2, 274), ('fiqh_zakat', 9, 60), ('fiqh_zakat', 57, 18),
              -- Fiqh Sawm
              ('fiqh_sawm', 2, 183), ('fiqh_sawm', 2, 184), ('fiqh_sawm', 2, 185), ('fiqh_sawm', 2, 187),
              -- Fiqh Dua & Dhikr
              ('fiqh_dua', 1, 5), ('fiqh_dua', 1, 6), ('fiqh_dua', 2, 186), ('fiqh_dua', 7, 55),
              ('fiqh_dua', 14, 40), ('fiqh_dua', 25, 74), ('fiqh_dua', 40, 60),
              ('fiqh_dhikr', 2, 152), ('fiqh_dhikr', 3, 191), ('fiqh_dhikr', 13, 28), ('fiqh_dhikr', 33, 41),
              -- Ethics Sabr & Shukr
              ('ethics_patience', 1, 5), ('ethics_patience', 2, 45), ('ethics_patience', 2, 153),
              ('ethics_patience', 2, 155), ('ethics_patience', 2, 156), ('ethics_patience', 2, 157),
              ('ethics_patience', 3, 200), ('ethics_patience', 103, 3),
              ('ethics_gratitude', 1, 2), ('ethics_gratitude', 2, 152), ('ethics_gratitude', 14, 7),
              ('ethics_gratitude', 16, 78), ('ethics_gratitude', 31, 12), ('ethics_gratitude', 55, 13),
              -- Kindness to Parents
              ('ethics_kindness_parents', 2, 83), ('ethics_kindness_parents', 4, 36),
              ('ethics_kindness_parents', 17, 23), ('ethics_kindness_parents', 17, 24),
              ('ethics_kindness_parents', 29, 8), ('ethics_kindness_parents', 31, 14),
              -- Social Justice & Trade
              ('social_justice', 4, 58), ('social_justice', 4, 135), ('social_justice', 5, 8),
              ('social_justice', 6, 152), ('social_justice', 16, 90), ('social_justice', 57, 25),
              ('social_trade', 2, 275), ('social_trade', 2, 282), ('social_trade', 4, 29),
              -- Stories of Prophets
              ('story_adam', 2, 30), ('story_adam', 2, 31), ('story_adam', 2, 34), ('story_adam', 2, 35),
              ('story_nuh', 7, 59), ('story_nuh', 7, 64), ('story_nuh', 11, 25), ('story_nuh', 71, 1),
              ('story_ibrahim', 2, 124), ('story_ibrahim', 2, 127), ('story_ibrahim', 6, 74), ('story_ibrahim', 14, 35),
              ('story_musa', 2, 49), ('story_musa', 2, 51), ('story_musa', 7, 103), ('story_musa', 20, 9),
              ('story_yusuf', 12, 1), ('story_yusuf', 12, 4), ('story_yusuf', 12, 15), ('story_yusuf', 12, 100),
              ('story_isa', 3, 45), ('story_isa', 3, 49), ('story_isa', 5, 110), ('story_isa', 19, 16),
              ('story_muhammad', 3, 144), ('story_muhammad', 9, 128), ('story_muhammad', 33, 40),
              ('story_muhammad', 48, 29), ('story_muhammad', 68, 4), ('story_muhammad', 94, 1),
              -- Day of Judgment & Jannah
              ('day_of_judgment', 1, 4), ('day_of_judgment', 2, 8), ('day_of_judgment', 2, 254),
              ('day_of_judgment', 2, 281), ('day_of_judgment', 14, 41), ('day_of_judgment', 22, 1),
              ('jannah', 1, 6), ('jannah', 1, 7), ('jannah', 2, 25), ('jannah', 2, 82),
              ('jannah', 3, 133), ('jannah', 18, 107), ('jannah', 47, 15),
              ('jahannam', 2, 24), ('jahannam', 2, 81), ('jahannam', 3, 131), ('jahannam', 67, 6),
              -- Nature & Cosmology
              ('nature_creation', 2, 29), ('nature_creation', 3, 190), ('nature_creation', 6, 1),
              ('nature_creation', 10, 3), ('nature_creation', 21, 30),
              ('nature_human_creation', 22, 5), ('nature_human_creation', 23, 12),
              ('nature_human_creation', 32, 7), ('nature_human_creation', 96, 1),
              -- Comfort & Relief
              ('comfort_hope', 3, 135), ('comfort_hope', 7, 156), ('comfort_hope', 39, 53),
              ('comfort_tawakkul', 3, 159), ('comfort_tawakkul', 8, 2), ('comfort_tawakkul', 65, 3),
              ('comfort_relief', 2, 214), ('comfort_relief', 94, 5), ('comfort_relief', 94, 6), ('comfort_relief', 65, 7);
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
