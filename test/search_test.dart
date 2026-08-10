import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:studyquran/core/database/app_database.dart';
import 'package:studyquran/core/database/daos/search_dao.dart';
import 'package:studyquran/core/database/fts_setup.dart';
import 'package:studyquran/features/search/domain/search_history.dart';

void main() {
  late AppDatabase db;
  late SearchDao searchDao;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    searchDao = db.searchDao;

    // Seed mock Surah 1 & 2
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

    await db.into(db.surahs).insert(
          SurahsCompanion.insert(
            number: const Value(2),
            nameArabic: 'البقرة',
            nameTranslit: 'Al-Baqarah',
            nameTranslation: 'The Cow',
            revelationPlace: 'madinah',
            ayahCount: 286,
          ),
        );

    // Seed mock Ayahs
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

    await db.into(db.ayahs).insert(
          AyahsCompanion.insert(
            globalAyahIndex: const Value(8),
            surahNumber: 2,
            ayahNumber: 1,
            arabicTextUthmani: 'الم',
            juz: 1,
            page: 2,
          ),
        );

    // Seed Translations
    await db.into(db.ayahTranslations).insert(
          AyahTranslationsCompanion.insert(
            translationId: 'en.saheeh',
            surahNumber: 1,
            ayahNumber: 1,
            textContent: 'In the name of Allah, the Entirely Merciful, the Especially Merciful.',
          ),
        );

    // Seed Roots & Words
    await db.into(db.roots).insert(
          RootsCompanion.insert(
            rootId: const Value(1),
            rootArabic: 'ر ح م',
            rootTranslit: 'r-h-m',
          ),
        );

    await db.into(db.words).insert(
          WordsCompanion.insert(
            surahNumber: 1,
            ayahNumber: 1,
            position: 3,
            arabicText: 'ٱلرَّحْمَٰنِ',
            transliteration: 'Ar-Rahman',
            rootId: const Value(1),
          ),
        );

    // Setup FTS5 indexes
    await FtsSetup.createCoreFtsTables(db.executor);
    await FtsSetup.indexTranslationFts(executor: db.executor, translationId: 'en.saheeh');
  });

  tearDown(() async {
    await db.close();
  });

  test('Combined free-text search returns matches from English translation with snippet', () async {
    final results = await searchDao.searchCombined(
      query: 'Merciful',
      filter: const SearchFilter(targetScope: 'all'),
    );

    expect(results.isNotEmpty, isTrue);
    expect(results.first.surahNumber, equals(1));
    expect(results.first.ayahNumber, equals(1));
    expect(results.first.textSnippet, contains('Merciful'));
  });

  test('Search filter limits results by surah and revelation period', () async {
    final meccaResults = await searchDao.searchCombined(
      query: 'Merciful',
      filter: const SearchFilter(revelationPlace: 'makkah'),
    );

    expect(meccaResults.isNotEmpty, isTrue);

    final medinaResults = await searchDao.searchCombined(
      query: 'Merciful',
      filter: const SearchFilter(revelationPlace: 'madinah'),
    );

    expect(medinaResults.isEmpty, isTrue);
  });

  test('Root Concordance returns all ayahs matching Arabic root r-h-m', () async {
    final occurrences = await searchDao.getConcordanceForRoot(rootArabic: 'ر ح م');

    expect(occurrences.isNotEmpty, isTrue);
    expect(occurrences.first.surahNumber, equals(1));
    expect(occurrences.first.ayahNumber, equals(1));
    expect(occurrences.first.matchedWord, contains('ٱلرَّحْمَٰنِ'));
  });

  test('SearchHistoryItem serialization and deserialization', () {
    final item = SearchHistoryItem(
      query: 'Rahman',
      filter: const SearchFilter(surahNumber: 1, targetScope: 'arabic'),
      timestamp: DateTime(2026, 8, 10),
      isPinned: true,
    );

    final jsonMap = item.toJson();
    final restored = SearchHistoryItem.fromJson(jsonMap);

    expect(restored.query, equals('Rahman'));
    expect(restored.filter.surahNumber, equals(1));
    expect(restored.filter.targetScope, equals('arabic'));
    expect(restored.isPinned, isTrue);
  });
}
