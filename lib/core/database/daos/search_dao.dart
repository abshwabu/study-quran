import 'package:drift/drift.dart';
import '../app_database.dart';

part 'search_dao.g.dart';

class FtsSearchResult {
  final int surahNumber;
  final int ayahNumber;
  final String surahNameTranslit;
  final String textSnippet;
  final String? translationId;
  final String sourceType; // 'arabic' or 'translation'

  FtsSearchResult({
    required this.surahNumber,
    required this.ayahNumber,
    required this.surahNameTranslit,
    required this.textSnippet,
    this.translationId,
    required this.sourceType,
  });
}

class RootOccurrenceResult {
  final int surahNumber;
  final int ayahNumber;
  final String surahNameTranslit;
  final String surahNameArabic;
  final String arabicTextUthmani;
  final String? translationText;
  final int wordPosition;
  final String matchedWord;

  RootOccurrenceResult({
    required this.surahNumber,
    required this.ayahNumber,
    required this.surahNameTranslit,
    required this.surahNameArabic,
    required this.arabicTextUthmani,
    this.translationText,
    required this.wordPosition,
    required this.matchedWord,
  });
}

class SearchFilter {
  final int? surahNumber;
  final int? juz;
  final String? revelationPlace; // 'makkah' or 'madinah'
  final String targetScope; // 'all', 'arabic', 'translation'

  const SearchFilter({
    this.surahNumber,
    this.juz,
    this.revelationPlace,
    this.targetScope = 'all',
  });

  SearchFilter copyWith({
    int? surahNumber,
    int? juz,
    String? revelationPlace,
    String? targetScope,
  }) {
    return SearchFilter(
      surahNumber: surahNumber ?? this.surahNumber,
      juz: juz ?? this.juz,
      revelationPlace: revelationPlace ?? this.revelationPlace,
      targetScope: targetScope ?? this.targetScope,
    );
  }
}

@DriftAccessor()
class SearchDao extends DatabaseAccessor<AppDatabase> with _$SearchDaoMixin {
  SearchDao(AppDatabase db) : super(db);

  /// Search full-text Arabic ayah content
  Future<List<FtsSearchResult>> searchArabic(String query, {SearchFilter filter = const SearchFilter()}) async {
    final cleanQuery = query.trim().replaceAll("'", "''");
    if (cleanQuery.isEmpty) return [];

    // FTS5 phrase or wildcard syntax
    final isPhrase = cleanQuery.startsWith('"') && cleanQuery.endsWith('"');
    final ftsQuery = isPhrase ? cleanQuery : '$cleanQuery*';

    final List<String> whereClauses = ['arabic_ayahs_fts MATCH ?'];
    final List<Variable> variables = [Variable.withString(ftsQuery)];

    if (filter.surahNumber != null) {
      whereClauses.add('arabic_ayahs_fts.surah_number = ?');
      variables.add(Variable.withInt(filter.surahNumber!));
    }
    if (filter.juz != null) {
      whereClauses.add('a.juz = ?');
      variables.add(Variable.withInt(filter.juz!));
    }
    if (filter.revelationPlace != null) {
      whereClauses.add('s.revelation_place = ?');
      variables.add(Variable.withString(filter.revelationPlace!));
    }

    final sql = '''
      SELECT 
        f.surah_number, 
        f.ayah_number, 
        s.name_translit, 
        snippet(arabic_ayahs_fts, 2, '<b>', '</b>', '...', 10) AS snippet
      FROM arabic_ayahs_fts f
      INNER JOIN surahs s ON s.number = f.surah_number
      INNER JOIN ayahs a ON a.surah_number = f.surah_number AND a.ayah_number = f.ayah_number
      WHERE ${whereClauses.join(' AND ')}
      ORDER BY f.rank;
    ''';

    final rows = await customSelect(sql, variables: variables).get();

    return rows.map((row) {
      return FtsSearchResult(
        surahNumber: row.read<int>('surah_number'),
        ayahNumber: row.read<int>('ayah_number'),
        surahNameTranslit: row.read<String>('name_translit'),
        textSnippet: row.read<String>('snippet'),
        sourceType: 'arabic',
      );
    }).toList();
  }

  /// Search full-text translation content
  Future<List<FtsSearchResult>> searchTranslation({
    required String query,
    String? translationId,
    SearchFilter filter = const SearchFilter(),
  }) async {
    final cleanQuery = query.trim().replaceAll("'", "''");
    if (cleanQuery.isEmpty) return [];

    final isPhrase = cleanQuery.startsWith('"') && cleanQuery.endsWith('"');
    final ftsQuery = isPhrase ? cleanQuery : '$cleanQuery*';

    final List<String> whereClauses = ['translation_fts MATCH ?'];
    final List<Variable> variables = [Variable.withString(ftsQuery)];

    if (translationId != null) {
      whereClauses.add('f.translation_id = ?');
      variables.add(Variable.withString(translationId));
    }
    if (filter.surahNumber != null) {
      whereClauses.add('f.surah_number = ?');
      variables.add(Variable.withInt(filter.surahNumber!));
    }
    if (filter.juz != null) {
      whereClauses.add('a.juz = ?');
      variables.add(Variable.withInt(filter.juz!));
    }
    if (filter.revelationPlace != null) {
      whereClauses.add('s.revelation_place = ?');
      variables.add(Variable.withString(filter.revelationPlace!));
    }

    final sql = '''
      SELECT 
        f.surah_number, 
        f.ayah_number, 
        f.translation_id,
        s.name_translit, 
        snippet(translation_fts, 3, '<b>', '</b>', '...', 10) AS snippet
      FROM translation_fts f
      INNER JOIN surahs s ON s.number = f.surah_number
      INNER JOIN ayahs a ON a.surah_number = f.surah_number AND a.ayah_number = f.ayah_number
      WHERE ${whereClauses.join(' AND ')}
      ORDER BY f.rank;
    ''';

    final rows = await customSelect(sql, variables: variables).get();

    return rows.map((row) {
      return FtsSearchResult(
        surahNumber: row.read<int>('surah_number'),
        ayahNumber: row.read<int>('ayah_number'),
        surahNameTranslit: row.read<String>('name_translit'),
        translationId: row.read<String>('translation_id'),
        textSnippet: row.read<String>('snippet'),
        sourceType: 'translation',
      );
    }).toList();
  }

  /// Combined Free-Text Search across Arabic & Translations
  Future<List<FtsSearchResult>> searchCombined({
    required String query,
    SearchFilter filter = const SearchFilter(),
  }) async {
    final results = <FtsSearchResult>[];

    if (filter.targetScope == 'all' || filter.targetScope == 'arabic') {
      final arabicMatches = await searchArabic(query, filter: filter);
      results.addAll(arabicMatches);
    }

    if (filter.targetScope == 'all' || filter.targetScope == 'translation') {
      final transMatches = await searchTranslation(query: query, filter: filter);
      results.addAll(transMatches);
    }

    return results;
  }

  /// Query all occurrences of an Arabic Root in the Quran (Root Concordance)
  Future<List<RootOccurrenceResult>> getConcordanceForRoot({
    required String rootArabic,
    String translationId = 'en.saheeh',
  }) async {
    final cleanRoot = rootArabic.trim();

    final sql = '''
      SELECT 
        w.surah_number, 
        w.ayah_number, 
        w.position AS word_position, 
        w.arabic_text AS matched_word,
        s.name_translit AS surah_translit,
        s.name_arabic AS surah_arabic,
        a.arabic_text_uthmani,
        t.text AS translation_text
      FROM words w
      INNER JOIN roots r ON r.root_id = w.root_id
      INNER JOIN surahs s ON s.number = w.surah_number
      INNER JOIN ayahs a ON a.surah_number = w.surah_number AND a.ayah_number = w.ayah_number
      LEFT JOIN ayah_translations t ON t.translation_id = ? AND t.surah_number = w.surah_number AND t.ayah_number = w.ayah_number
      WHERE r.root_arabic = ? OR r.root_translit = ?
      ORDER BY w.surah_number, w.ayah_number, w.position;
    ''';

    final rows = await customSelect(
      sql,
      variables: [
        Variable.withString(translationId),
        Variable.withString(cleanRoot),
        Variable.withString(cleanRoot),
      ],
    ).get();

    return rows.map((row) {
      return RootOccurrenceResult(
        surahNumber: row.read<int>('surah_number'),
        ayahNumber: row.read<int>('ayah_number'),
        surahNameTranslit: row.read<String>('surah_translit'),
        surahNameArabic: row.read<String>('surah_arabic'),
        arabicTextUthmani: row.read<String>('arabic_text_uthmani'),
        translationText: row.read<String?>('translation_text'),
        wordPosition: row.read<int>('word_position'),
        matchedWord: row.read<String>('matched_word'),
      );
    }).toList();
  }

  /// Get Root Metadata
  Future<Root?> getRootMeta(String rootArabic) async {
    final cleanRoot = rootArabic.trim();
    return (select(db.roots)
          ..where((r) => r.rootArabic.equals(cleanRoot) | r.rootTranslit.equals(cleanRoot)))
        .getSingleOrNull();
  }
}
