import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:studyquran/core/database/app_database.dart';
import 'package:studyquran/core/database/daos/quran_dao.dart';
import 'package:studyquran/core/database/daos/search_dao.dart';
import 'package:studyquran/core/database/daos/content_pack_dao.dart';
import 'package:studyquran/core/database/fts_setup.dart';

void main() {
  late AppDatabase db;
  late QuranDao quranDao;
  late SearchDao searchDao;
  late ContentPackDao packDao;

  setUp(() async {
    // Use an in-memory database for testing
    db = AppDatabase(NativeDatabase.memory());
    quranDao = db.quranDao;
    searchDao = db.searchDao;
    packDao = db.contentPackDao;

    // Seed mock test data
    await db.into(db.surahs).insert(
          SurahsCompanion.insert(
            number: const Value(1),
            nameArabic: 'الفاتحة',
            nameTranslit: 'Al-Fatihah',
            nameTranslation: 'The Opening',
            revelationPlace: 'makkah',
            ayahCount: 7,
          ),
        );

    await db.into(db.ayahs).insert(
          AyahsCompanion.insert(
            globalAyahIndex: const Value(1),
            surahNumber: 1,
            ayahNumber: 1,
            arabicTextUthmani: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
            juz: 1,
            page: 1,
          ),
        );

    await db.into(db.translationsMeta).insert(
          TranslationsMetaCompanion.insert(
            translationId: 'en.saheeh',
            language: 'en',
            translatorName: 'Saheeh International',
            source: 'Tanzil',
            licenseNote: 'Permissive',
          ),
        );

    await db.into(db.ayahTranslations).insert(
          AyahTranslationsCompanion.insert(
            translationId: 'en.saheeh',
            surahNumber: 1,
            ayahNumber: 1,
            textContent: 'In the name of Allah, the Entirely Merciful, the Especially Merciful.',
          ),
        );

    // Initialize FTS5 and index translation
    await FtsSetup.createCoreFtsTables(db.executor);
    await FtsSetup.indexTranslationFts(executor: db.executor, translationId: 'en.saheeh');
  });

  tearDown(() async {
    await db.close();
  });

  test('Query Surah 1 ayahs with Arabic text and default translation', () async {
    final ayahs = await quranDao.getAyahsForSurah(surahNumber: 1);
    expect(ayahs.length, equals(1));
    expect(ayahs.first.ayah.surahNumber, equals(1));
    expect(ayahs.first.ayah.ayahNumber, equals(1));
    expect(ayahs.first.ayah.arabicTextUthmani, contains('بِسْمِ ٱللَّهِ'));
    expect(ayahs.first.translationText, contains('Entirely Merciful'));
  });

  test('FTS5 translation search returns correct match for test query', () async {
    final searchResults = await searchDao.searchTranslation(query: 'Merciful', translationId: 'en.saheeh');
    expect(searchResults.isNotEmpty, isTrue);
    expect(searchResults.first.surahNumber, equals(1));
    expect(searchResults.first.ayahNumber, equals(1));
    expect(searchResults.first.textSnippet, contains('Merciful'));
  });

  test('ContentPackDao manages pack download status', () async {
    await packDao.upsertPack(
      ContentPacksCompanion.insert(
        packId: 'en.saheeh',
        type: 'translation',
        name: 'Saheeh International',
        version: '1.0.0',
        downloadUrl: 'http://example.com',
        sizeBytes: 1000,
        licenseNote: 'Permissive',
      ),
    );

    await packDao.markAsDownloaded('en.saheeh');
    final pack = await packDao.getPackById('en.saheeh');
    expect(pack?.downloaded, isTrue);
  });
}
