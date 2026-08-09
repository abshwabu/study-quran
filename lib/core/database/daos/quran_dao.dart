import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/surahs.dart';
import '../tables/ayahs.dart';
import '../tables/translations.dart';
import '../tables/words_roots.dart';

part 'quran_dao.g.dart';

class AyahWithTranslation {
  final Ayah ayah;
  final String? translationText;
  final String? translationId;

  AyahWithTranslation({
    required this.ayah,
    this.translationText,
    this.translationId,
  });
}

@DriftAccessor(tables: [Surahs, Ayahs, TranslationsMeta, AyahTranslations, Words, Roots])
class QuranDao extends DatabaseAccessor<AppDatabase> with _$QuranDaoMixin {
  QuranDao(AppDatabase db) : super(db);

  /// Fetch all 114 Surahs
  Future<List<Surah>> getAllSurahs() => select(surahs).get();

  /// Get specific Surah by number
  Future<Surah?> getSurahByNumber(int number) {
    return (select(surahs)..where((s) => s.number.equals(number))).getSingleOrNull();
  }

  /// Get all Ayahs for a Surah with optional translation
  Future<List<AyahWithTranslation>> getAyahsForSurah({
    required int surahNumber,
    String defaultTranslationId = 'en.saheeh',
  }) async {
    final query = select(ayahs).join([
      leftOuterJoin(
        ayahTranslations,
        ayahTranslations.surahNumber.equalsExp(ayahs.surahNumber) &
            ayahTranslations.ayahNumber.equalsExp(ayahs.ayahNumber) &
            ayahTranslations.translationId.equals(defaultTranslationId),
      ),
    ])
      ..where(ayahs.surahNumber.equals(surahNumber))
      ..orderBy([OrderingTerm.asc(ayahs.ayahNumber)]);

    final rows = await query.get();

    return rows.map((row) {
      final ayah = row.readTable(ayahs);
      final translation = row.readTableOrNull(ayahTranslations);
      return AyahWithTranslation(
        ayah: ayah,
        translationText: translation?.textContent,
        translationId: translation?.translationId,
      );
    }).toList();
  }

  /// Get single Ayah by Surah & Ayah number
  Future<AyahWithTranslation?> getAyah({
    required int surahNumber,
    required int ayahNumber,
    String translationId = 'en.saheeh',
  }) async {
    final query = select(ayahs).join([
      leftOuterJoin(
        ayahTranslations,
        ayahTranslations.surahNumber.equalsExp(ayahs.surahNumber) &
            ayahTranslations.ayahNumber.equalsExp(ayahs.ayahNumber) &
            ayahTranslations.translationId.equals(translationId),
      ),
    ])
      ..where(ayahs.surahNumber.equals(surahNumber) & ayahs.ayahNumber.equals(ayahNumber));

    final row = await query.getSingleOrNull();
    if (row == null) return null;

    return AyahWithTranslation(
      ayah: row.readTable(ayahs),
      translationText: row.readTableOrNull(ayahTranslations)?.textContent,
      translationId: row.readTableOrNull(ayahTranslations)?.translationId,
    );
  }

  // --- Hook for Prompts 04 & 05: Morphology & Roots ---
  Future<List<Word>> getWordsForAyah(int surahNumber, int ayahNumber) {
    return (select(words)
          ..where((w) => w.surahNumber.equals(surahNumber) & w.ayahNumber.equals(ayahNumber))
          ..orderBy([(w) => OrderingTerm.asc(w.position)]))
        .get();
  }
}
