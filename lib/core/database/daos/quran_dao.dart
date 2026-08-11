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

class WordWithRoot {
  final Word word;
  final Root? root;

  WordWithRoot({
    required this.word,
    this.root,
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

  /// Fetch word-by-word segmentations with joined root metadata for an Ayah
  Future<List<WordWithRoot>> getWordsWithRootsForAyah(int surahNumber, int ayahNumber) async {
    final query = select(words).join([
      leftOuterJoin(roots, roots.rootId.equalsExp(words.rootId)),
    ])
      ..where(words.surahNumber.equals(surahNumber) & words.ayahNumber.equals(ayahNumber))
      ..orderBy([OrderingTerm.asc(words.position)]);

    final rows = await query.get();
    return rows.map((r) {
      return WordWithRoot(
        word: r.readTable(words),
        root: r.readTableOrNull(roots),
      );
    }).toList();
  }

  /// Fetch all Root entries for the Root Browser
  Future<List<Root>> getAllRoots() {
    return (select(roots)..orderBy([(r) => OrderingTerm.asc(r.rootTranslit)])).get();
  }

  /// Search roots by query
  Future<List<Root>> searchRoots(String searchQuery) {
    final clean = searchQuery.trim();
    if (clean.isEmpty) return getAllRoots();

    return (select(roots)
          ..where((r) => r.rootArabic.contains(clean) | r.rootTranslit.contains(clean) | r.meaningsSummary.contains(clean))
          ..orderBy([(r) => OrderingTerm.asc(r.rootTranslit)]))
        .get();
  }
}
