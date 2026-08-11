import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;

import 'package:drift/native.dart';
import 'package:studyquran/core/database/app_database.dart';
import 'package:studyquran/core/database/daos/thematic_dao.dart';

void main() {
  late AppDatabase db;
  late ThematicDao thematicDao;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    thematicDao = db.thematicDao;

    // Seed Surah 1 & 2 & 109
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

    await db.into(db.surahs).insert(
          SurahsCompanion.insert(
            number: const Value(109),
            nameArabic: 'الكافرون',
            nameTranslit: 'Al-Kafirun',
            nameTranslation: 'The Disbelievers',
            revelationPlace: 'makkah',
            ayahCount: 6,
          ),
        );

    // Seed Ayahs
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
            globalAyahIndex: const Value(3),
            surahNumber: 1,
            ayahNumber: 3,
            arabicTextUthmani: 'ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
            juz: 1,
            page: 1,
          ),
        );

    await db.into(db.ayahs).insert(
          AyahsCompanion.insert(
            globalAyahIndex: const Value(5),
            surahNumber: 1,
            ayahNumber: 5,
            arabicTextUthmani: 'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
            juz: 1,
            page: 1,
          ),
        );

    await db.into(db.ayahs).insert(
          AyahsCompanion.insert(
            globalAyahIndex: const Value(10),
            surahNumber: 2,
            ayahNumber: 3,
            arabicTextUthmani: 'ٱلَّذِينَ يُؤْمِنُونَ بِٱلْغَيْبِ وَيُقِيمُونَ ٱلصَّلَاةَ وَمِمَّا رَزَقْنَاهُمْ يُنفِقُونَ',
            juz: 1,
            page: 2,
          ),
        );

    await db.into(db.ayahs).insert(
          AyahsCompanion.insert(
            globalAyahIndex: const Value(263),
            surahNumber: 2,
            ayahNumber: 256,
            arabicTextUthmani: 'لَآ إِكْرَاهَ فِى ٱلدِّينِ',
            juz: 3,
            page: 42,
          ),
        );

    await db.into(db.ayahs).insert(
          AyahsCompanion.insert(
            globalAyahIndex: const Value(6220),
            surahNumber: 109,
            ayahNumber: 6,
            arabicTextUthmani: 'لَكُمْ دِينُكُمْ وَلِيَ دِينِ',
            juz: 30,
            page: 603,
          ),
        );

    // Seed Topics
    await db.into(db.topics).insert(
          TopicsCompanion.insert(
            topicId: 'worship',
            name: 'Worship & Practice',
            category: const Value('Practice'),
          ),
        );

    await db.into(db.topics).insert(
          TopicsCompanion.insert(
            topicId: 'prayer',
            name: 'Salah & Supplication',
            parentTopicId: const Value('worship'),
            category: const Value('Practice'),
          ),
        );

    await db.into(db.topicAyahs).insert(
          TopicAyahsCompanion.insert(
            topicId: 'prayer',
            surahNumber: 1,
            ayahNumber: 5,
          ),
        );

    // Seed Cross References for 3 test ayahs
    // Test 1: Surah 1:1 -> 1:3 (similar theme)
    await db.into(db.crossReferences).insert(
          CrossReferencesCompanion.insert(
            sourceSurah: 1,
            sourceAyah: 1,
            targetSurah: 1,
            targetAyah: 3,
            relationshipType: 'similar_theme',
            notes: const Value('Reiteration of Ar-Rahman Ar-Raheem'),
          ),
        );

    // Test 2: Surah 1:5 -> 2:3 (similar theme)
    await db.into(db.crossReferences).insert(
          CrossReferencesCompanion.insert(
            sourceSurah: 1,
            sourceAyah: 5,
            targetSurah: 2,
            targetAyah: 3,
            relationshipType: 'similar_theme',
            notes: const Value('Worship coupled with establishing prayer'),
          ),
        );

    // Test 3: Surah 2:256 -> 109:6 (scholarly abrogation naskh)
    await db.into(db.crossReferences).insert(
          CrossReferencesCompanion.insert(
            sourceSurah: 2,
            sourceAyah: 256,
            targetSurah: 109,
            targetAyah: 6,
            relationshipType: 'scholarly_abrogation_naskh',
            notes: const Value('Freedom of religion discussed by classical scholars'),
          ),
        );

    // Seed Asbab al-Nuzul
    await db.into(db.asbabAlNuzul).insert(
          AsbabAlNuzulCompanion.insert(
            surahNumber: 1,
            startAyah: 1,
            endAyah: 7,
            textContent: 'Revealed in Makkah when Gabriel instructed the Prophet to recite Al-Fatihah.',
            sourceNote: 'Asbab al-Nuzul by Al-Wahidi',
          ),
        );
  });

  tearDown(() async {
    await db.close();
  });

  test('Hierarchical topic query returns root and child subtopics correctly', () async {
    final rootTopics = await thematicDao.getRootTopics();
    expect(rootTopics.length, equals(1));
    expect(rootTopics.first.topicId, equals('worship'));

    final childTopics = await thematicDao.getChildTopics('worship');
    expect(childTopics.length, equals(1));
    expect(childTopics.first.topicId, equals('prayer'));
  });

  test('Topic ayah lookup returns ayahs mapped to topic prayer', () async {
    final topicAyahs = await thematicDao.getAyahsForTopic('prayer');
    expect(topicAyahs.length, equals(1));
    expect(topicAyahs.first.surahNumber, equals(1));
    expect(topicAyahs.first.ayahNumber, equals(5));
  });

  test('Cross-reference query returns correct related ayahs and relationship types for test verses', () async {
    // Spot check 1: Surah 1:1
    final crossRef1 = await thematicDao.getCrossReferencesForAyah(surahNumber: 1, ayahNumber: 1);
    expect(crossRef1.length, equals(1));
    expect(crossRef1.first.crossRef.targetAyah, equals(3));
    expect(crossRef1.first.crossRef.relationshipType, equals('similar_theme'));

    // Spot check 2: Surah 1:5
    final crossRef2 = await thematicDao.getCrossReferencesForAyah(surahNumber: 1, ayahNumber: 5);
    expect(crossRef2.length, equals(1));
    expect(crossRef2.first.crossRef.targetSurah, equals(2));
    expect(crossRef2.first.crossRef.targetAyah, equals(3));

    // Spot check 3: Surah 2:256 (Naskh / Scholarly Abrogation)
    final crossRef3 = await thematicDao.getCrossReferencesForAyah(surahNumber: 2, ayahNumber: 256);
    expect(crossRef3.length, equals(1));
    expect(crossRef3.first.crossRef.relationshipType, equals('scholarly_abrogation_naskh'));
    expect(crossRef3.first.targetSurahNameTranslit, equals('Al-Kafirun'));
  });

  test('Asbab al-Nuzul returns text for recorded verse and null for unrecorded verse', () async {
    final asbabRecorded = await thematicDao.getAsbabAlNuzulForAyah(surahNumber: 1, ayahNumber: 1);
    expect(asbabRecorded, isNotNull);
    expect(asbabRecorded!.sourceNote, contains('Al-Wahidi'));

    final asbabUnrecorded = await thematicDao.getAsbabAlNuzulForAyah(surahNumber: 109, ayahNumber: 6);
    expect(asbabUnrecorded, isNull);
  });
}
