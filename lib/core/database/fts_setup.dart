import 'package:drift/drift.dart';

/// Helper class to manage FTS5 virtual tables and indexes.
/// Supports both Arabic text search and repeatable per-translation FTS indexing.
class FtsSetup {
  static Future<void> createCoreFtsTables(QueryExecutor executor) async {
    // 1. Arabic Ayah FTS5 Table
    await executor.runCustom('''
      CREATE VIRTUAL TABLE IF NOT EXISTS arabic_ayahs_fts USING fts5(
        surah_number UNINDEXED,
        ayah_number UNINDEXED,
        arabic_text_uthmani
      );
    ''');

    // 2. Translation FTS5 Table (Shared virtual table with translation_id column)
    await executor.runCustom('''
      CREATE VIRTUAL TABLE IF NOT EXISTS translation_fts USING fts5(
        translation_id UNINDEXED,
        surah_number UNINDEXED,
        ayah_number UNINDEXED,
        text
      );
    ''');
  }

  /// Repeatable pattern to register and index a newly installed translation into FTS5
  static Future<void> indexTranslationFts({
    required QueryExecutor executor,
    required String translationId,
  }) async {
    // Delete existing entries for this translation to avoid duplication
    await executor.runCustom(
      'DELETE FROM translation_fts WHERE translation_id = ?;',
      [translationId],
    );

    // Populate FTS5 table from ayah_translations
    await executor.runCustom(
      '''
      INSERT INTO translation_fts (translation_id, surah_number, ayah_number, text)
      SELECT translation_id, surah_number, ayah_number, text
      FROM ayah_translations
      WHERE translation_id = ?;
      ''',
      [translationId],
    );
  }
}
