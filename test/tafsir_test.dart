import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:studyquran/core/database/app_database.dart';
import 'package:studyquran/core/database/daos/tafsir_dao.dart';

void main() {
  late AppDatabase db;
  late TafsirDao tafsirDao;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    tafsirDao = db.tafsirDao;

    // Seed mock Tafsir metadata
    await tafsirDao.upsertTafsirMeta(
      TafsirsMetaCompanion.insert(
        tafsirId: 'ar.muyassar',
        name: 'تفسير الميسر',
        author: 'مجموعة من العلماء',
        language: 'ar',
        source: 'Quran.com',
        licenseNote: 'Public Domain',
      ),
    );

    await tafsirDao.upsertTafsirMeta(
      TafsirsMetaCompanion.insert(
        tafsirId: 'en.jalalayn',
        name: 'Tafsir al-Jalalayn',
        author: 'Jalal ad-Din',
        language: 'en',
        source: 'altafsir.com',
        licenseNote: 'Public Domain',
      ),
    );

    // Seed single-ayah commentary for Surah 1:1
    await tafsirDao.insertTafsirContentEntry(
      TafsirContentCompanion.insert(
        tafsirId: 'ar.muyassar',
        surahNumber: 1,
        startAyah: 1,
        endAyah: 1,
        textContent: 'أبدأ قراءة القرآن باسم الله مستعيناً به',
      ),
    );

    await tafsirDao.insertTafsirContentEntry(
      TafsirContentCompanion.insert(
        tafsirId: 'en.jalalayn',
        surahNumber: 1,
        startAyah: 1,
        endAyah: 1,
        textContent: 'In the Name of God, the Merciful, the Compassionate',
      ),
    );

    // Seed range-based commentary for Surah 2 (Ayahs 1 to 5 together)
    await tafsirDao.insertTafsirContentEntry(
      TafsirContentCompanion.insert(
        tafsirId: 'en.jalalayn',
        surahNumber: 2,
        startAyah: 1,
        endAyah: 5,
        textContent: 'Range commentary for Al-Baqarah verses 1 through 5.',
      ),
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('Query single-ayah Tafsir commentary for Surah 1:1', () async {
    final entry = await tafsirDao.getCommentaryForAyah(
      tafsirId: 'ar.muyassar',
      surahNumber: 1,
      ayahNumber: 1,
    );

    expect(entry, isNotNull);
    expect(entry!.meta.tafsirId, equals('ar.muyassar'));
    expect(entry.content.textContent, contains('أبدأ قراءة القرآن'));
    expect(entry.content.startAyah, equals(1));
    expect(entry.content.endAyah, equals(1));
  });

  test('Query range-based Tafsir commentary (Ayah 3 falls within range 1-5)', () async {
    final entry = await tafsirDao.getCommentaryForAyah(
      tafsirId: 'en.jalalayn',
      surahNumber: 2,
      ayahNumber: 3,
    );

    expect(entry, isNotNull);
    expect(entry!.content.startAyah, equals(1));
    expect(entry.content.endAyah, equals(5));
    expect(entry.content.textContent, contains('Range commentary for Al-Baqarah'));
  });

  test('Multi-Tafsir comparison query returns entries for all requested Tafsirs', () async {
    final comparison = await tafsirDao.getTafsirsForAyahComparison(
      tafsirIds: ['ar.muyassar', 'en.jalalayn'],
      surahNumber: 1,
      ayahNumber: 1,
    );

    expect(comparison.length, equals(2));
    final ids = comparison.map((c) => c.meta.tafsirId).toList();
    expect(ids, containsAll(['ar.muyassar', 'en.jalalayn']));
  });
}
