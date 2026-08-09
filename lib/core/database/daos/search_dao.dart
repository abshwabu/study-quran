import 'package:drift/drift.dart';
import '../app_database.dart';

part 'search_dao.g.dart';

class FtsSearchResult {
  final int surahNumber;
  final int ayahNumber;
  final String textSnippet;
  final String? translationId;

  FtsSearchResult({
    required this.surahNumber,
    required this.ayahNumber,
    required this.textSnippet,
    this.translationId,
  });
}

@DriftAccessor()
class SearchDao extends DatabaseAccessor<AppDatabase> with _$SearchDaoMixin {
  SearchDao(AppDatabase db) : super(db);

  /// Search full-text Arabic ayah content
  Future<List<FtsSearchResult>> searchArabic(String query) async {
    final cleanQuery = query.trim().replaceAll("'", "''").replaceAll('*', '');
    if (cleanQuery.isEmpty) return [];

    final ftsQuery = '$cleanQuery*';

    final rows = await customSelect(
      'SELECT surah_number, ayah_number, snippet(arabic_ayahs_fts, 2, "<b>", "</b>", "...", 10) AS snippet '
      'FROM arabic_ayahs_fts WHERE arabic_ayahs_fts MATCH ? ORDER BY rank;',
      variables: [Variable.withString(ftsQuery)],
    ).get();

    return rows.map((row) {
      return FtsSearchResult(
        surahNumber: row.read<int>('surah_number'),
        ayahNumber: row.read<int>('ayah_number'),
        textSnippet: row.read<String>('snippet'),
      );
    }).toList();
  }

  /// Search full-text translation content (repeatable for any installed translationId)
  Future<List<FtsSearchResult>> searchTranslation({
    required String query,
    String? translationId,
  }) async {
    final cleanQuery = query.trim().replaceAll("'", "''").replaceAll('*', '');
    if (cleanQuery.isEmpty) return [];

    final ftsQuery = '$cleanQuery*';

    final sql = translationId != null
        ? 'SELECT surah_number, ayah_number, translation_id, snippet(translation_fts, 3, "<b>", "</b>", "...", 10) AS snippet '
          'FROM translation_fts WHERE translation_fts MATCH ? AND translation_id = ? ORDER BY rank;'
        : 'SELECT surah_number, ayah_number, translation_id, snippet(translation_fts, 3, "<b>", "</b>", "...", 10) AS snippet '
          'FROM translation_fts WHERE translation_fts MATCH ? ORDER BY rank;';

    final vars = translationId != null
        ? [Variable.withString(ftsQuery), Variable.withString(translationId)]
        : [Variable.withString(ftsQuery)];

    final rows = await customSelect(sql, variables: vars).get();

    return rows.map((row) {
      return FtsSearchResult(
        surahNumber: row.read<int>('surah_number'),
        ayahNumber: row.read<int>('ayah_number'),
        translationId: row.read<String>('translation_id'),
        textSnippet: row.read<String>('snippet'),
      );
    }).toList();
  }
}
