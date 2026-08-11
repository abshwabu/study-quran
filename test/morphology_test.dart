import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:studyquran/core/database/app_database.dart';
import 'package:studyquran/core/database/daos/quran_dao.dart';

void main() {
  late AppDatabase db;
  late QuranDao quranDao;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    quranDao = db.quranDao;

    // Seed mock Surah 1
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

    // Seed mock Roots
    await db.into(db.roots).insert(
          RootsCompanion.insert(
            rootId: const Value(1),
            rootArabic: 'ر ح م',
            rootTranslit: 'r-h-m',
            meaningsSummary: const Value('To show mercy, compassion'),
            occurrenceCount: const Value(339),
          ),
        );

    await db.into(db.roots).insert(
          RootsCompanion.insert(
            rootId: const Value(4),
            rootArabic: 'ع ب د',
            rootTranslit: 'a-b-d',
            meaningsSummary: const Value('To serve, worship'),
            occurrenceCount: const Value(275),
          ),
        );

    // Seed 5 distinct words across different Parts of Speech (POS)
    // 1. Preposition + Noun
    await db.into(db.words).insert(
          WordsCompanion.insert(
            surahNumber: 1,
            ayahNumber: 1,
            position: 1,
            arabicText: 'بِسْمِ',
            transliteration: 'Bi-smi',
            translationGloss: const Value('In (the) name'),
            partOfSpeech: const Value('Preposition + Noun'),
            grammarDetails: const Value('Genitive noun prefixed with preposition bi-'),
            rootId: const Value(1),
          ),
        );

    // 2. Proper Noun
    await db.into(db.words).insert(
          WordsCompanion.insert(
            surahNumber: 1,
            ayahNumber: 1,
            position: 2,
            arabicText: 'ٱللَّهِ',
            transliteration: 'Allah',
            translationGloss: const Value('of Allah'),
            partOfSpeech: const Value('Proper Noun'),
            grammarDetails: const Value('Genitive proper noun (Majrur)'),
            rootId: const Value(1),
          ),
        );

    // 3. Adjective
    await db.into(db.words).insert(
          WordsCompanion.insert(
            surahNumber: 1,
            ayahNumber: 1,
            position: 3,
            arabicText: 'ٱلرَّحْمَٰنِ',
            transliteration: 'Ar-Rahman',
            translationGloss: const Value('the Entirely Merciful'),
            partOfSpeech: const Value('Adjective'),
            grammarDetails: const Value('Genitive masculine singular adjective'),
            rootId: const Value(1),
          ),
        );

    // 4. Verb
    await db.into(db.words).insert(
          WordsCompanion.insert(
            surahNumber: 1,
            ayahNumber: 5,
            position: 2,
            arabicText: 'نَعْبُدُ',
            transliteration: "na'budu",
            translationGloss: const Value('we worship'),
            partOfSpeech: const Value('Verb'),
            grammarDetails: const Value('1st person plural imperfect verb'),
            rootId: const Value(4),
          ),
        );

    // 5. Active Participle
    await db.into(db.words).insert(
          WordsCompanion.insert(
            surahNumber: 1,
            ayahNumber: 7,
            position: 9,
            arabicText: 'ٱلضَّالِّينَ',
            transliteration: 'ad-dallin',
            translationGloss: const Value('those who are astray'),
            partOfSpeech: const Value('Active Participle'),
            grammarDetails: const Value('Genitive masculine plural active participle'),
            rootId: const Value(1),
          ),
        );
  });

  tearDown(() async {
    await db.close();
  });

  test('getWordsWithRootsForAyah fetches word segmentations with POS, gloss, and grammar details', () async {
    final wordsList = await quranDao.getWordsWithRootsForAyah(1, 1);

    expect(wordsList.length, equals(3));
    
    // Spot check 1: Preposition + Noun
    final w1 = wordsList[0].word;
    expect(w1.arabicText, equals('بِسْمِ'));
    expect(w1.partOfSpeech, equals('Preposition + Noun'));
    expect(w1.translationGloss, equals('In (the) name'));

    // Spot check 2: Proper Noun
    final w2 = wordsList[1].word;
    expect(w2.arabicText, equals('ٱللَّهِ'));
    expect(w2.partOfSpeech, equals('Proper Noun'));
    expect(w2.grammarDetails, contains('Genitive proper noun'));

    // Spot check 3: Adjective with joined root
    final w3 = wordsList[2];
    expect(w3.word.partOfSpeech, equals('Adjective'));
    expect(w3.root, isNotNull);
    expect(w3.root!.rootArabic, equals('ر ح م'));
    expect(w3.root!.occurrenceCount, equals(339));
  });

  test('Spot check Verb and Active Participle morphology data', () async {
    final verbWords = await quranDao.getWordsWithRootsForAyah(1, 5);
    expect(verbWords.first.word.partOfSpeech, equals('Verb'));
    expect(verbWords.first.word.translationGloss, equals('we worship'));
    expect(verbWords.first.root!.rootArabic, equals('ع ب د'));

    final participleWords = await quranDao.getWordsWithRootsForAyah(1, 7);
    expect(participleWords.first.word.partOfSpeech, equals('Active Participle'));
    expect(participleWords.first.word.grammarDetails, contains('active participle'));
  });

  test('Root Browser queries return roots sorted and filtered', () async {
    final allRoots = await quranDao.getAllRoots();
    expect(allRoots.length, equals(2));

    final searchResults = await quranDao.searchRoots('Mercy');
    expect(searchResults.length, equals(1));
    expect(searchResults.first.rootArabic, equals('ر ح م'));
  });
}
