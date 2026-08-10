import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/tafsir.dart';

part 'tafsir_dao.g.dart';

class TafsirEntryWithMeta {
  final TafsirMeta meta;
  final TafsirContentData content;

  TafsirEntryWithMeta({
    required this.meta,
    required this.content,
  });
}

@DriftAccessor(tables: [TafsirsMeta, TafsirContent])
class TafsirDao extends DatabaseAccessor<AppDatabase> with _$TafsirDaoMixin {
  TafsirDao(AppDatabase db) : super(db);

  /// Fetch all Tafsir metadata entries
  Future<List<TafsirMeta>> getAllTafsirsMeta() => select(tafsirsMeta).get();

  /// Get specific Tafsir metadata by ID
  Future<TafsirMeta?> getTafsirMetaById(String tafsirId) {
    return (select(tafsirsMeta)..where((t) => t.tafsirId.equals(tafsirId))).getSingleOrNull();
  }

  /// Query commentary for a single Ayah (supporting single-ayah and range-based entries)
  Future<TafsirEntryWithMeta?> getCommentaryForAyah({
    required String tafsirId,
    required int surahNumber,
    required int ayahNumber,
  }) async {
    final query = select(tafsirContent).join([
      innerJoin(tafsirsMeta, tafsirsMeta.tafsirId.equalsExp(tafsirContent.tafsirId)),
    ])
      ..where(
        tafsirContent.tafsirId.equals(tafsirId) &
            tafsirContent.surahNumber.equals(surahNumber) &
            tafsirContent.startAyah.isSmallerOrEqualValue(ayahNumber) &
            tafsirContent.endAyah.isBiggerOrEqualValue(ayahNumber),
      );

    final row = await query.getSingleOrNull();
    if (row == null) return null;

    return TafsirEntryWithMeta(
      meta: row.readTable(tafsirsMeta),
      content: row.readTable(tafsirContent),
    );
  }

  /// Multi-Tafsir Comparison Query for a single Ayah
  Future<List<TafsirEntryWithMeta>> getTafsirsForAyahComparison({
    required List<String> tafsirIds,
    required int surahNumber,
    required int ayahNumber,
  }) async {
    if (tafsirIds.isEmpty) return [];

    final query = select(tafsirContent).join([
      innerJoin(tafsirsMeta, tafsirsMeta.tafsirId.equalsExp(tafsirContent.tafsirId)),
    ])
      ..where(
        tafsirContent.tafsirId.isIn(tafsirIds) &
            tafsirContent.surahNumber.equals(surahNumber) &
            tafsirContent.startAyah.isSmallerOrEqualValue(ayahNumber) &
            tafsirContent.endAyah.isBiggerOrEqualValue(ayahNumber),
      );

    final rows = await query.get();

    return rows.map((row) {
      return TafsirEntryWithMeta(
        meta: row.readTable(tafsirsMeta),
        content: row.readTable(tafsirContent),
      );
    }).toList();
  }

  /// Insert or update Tafsir metadata
  Future<void> upsertTafsirMeta(TafsirsMetaCompanion meta) {
    return into(tafsirsMeta).insertOnConflictUpdate(meta);
  }

  /// Insert Tafsir content entry
  Future<void> insertTafsirContentEntry(TafsirContentCompanion entry) {
    return into(tafsirContent).insert(entry);
  }
}
