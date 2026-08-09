import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/content_packs.dart';

part 'content_pack_dao.g.dart';

@DriftAccessor(tables: [ContentPacks])
class ContentPackDao extends DatabaseAccessor<AppDatabase> with _$ContentPackDaoMixin {
  ContentPackDao(AppDatabase db) : super(db);

  /// Fetch all registered content packs
  Future<List<ContentPack>> getAllPacks() => select(contentPacks).get();

  /// Watch downloaded packs for reactive UI updates
  Stream<List<ContentPack>> watchDownloadedPacks() {
    return (select(contentPacks)..where((p) => p.downloaded.equals(true))).watch();
  }

  /// Check status of a single pack
  Future<ContentPack?> getPackById(String packId) {
    return (select(contentPacks)..where((p) => p.packId.equals(packId))).getSingleOrNull();
  }

  /// Insert or update pack metadata
  Future<void> upsertPack(ContentPacksCompanion pack) {
    return into(contentPacks).insertOnConflictUpdate(pack);
  }

  /// Mark pack as downloaded
  Future<void> markAsDownloaded(String packId) {
    return (update(contentPacks)..where((p) => p.packId.equals(packId)))
        .write(const ContentPacksCompanion(downloaded: Value(true)));
  }

  /// Delete/uninstall pack status
  Future<void> markAsDeleted(String packId) {
    return (update(contentPacks)..where((p) => p.packId.equals(packId)))
        .write(const ContentPacksCompanion(downloaded: Value(false)));
  }
}
