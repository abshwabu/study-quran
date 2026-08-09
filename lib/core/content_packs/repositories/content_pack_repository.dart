import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:drift/drift.dart';
import '../../database/app_database.dart';
import '../../database/daos/content_pack_dao.dart';
import '../../database/fts_setup.dart';
import '../models/pack_manifest.dart';

abstract class ContentPackRepository {
  Future<List<PackManifestItem>> fetchAvailablePacks();
  Future<bool> isPackDownloaded(String packId);
  Future<void> importTranslationPack({
    required PackManifestItem packMeta,
    required List<Map<String, dynamic>> translationData,
  });
  Future<void> removePack(String packId);
}

class ContentPackRepositoryImpl implements ContentPackRepository {
  final AppDatabase db;
  final ContentPackDao packDao;

  ContentPackRepositoryImpl({
    required this.db,
    required this.packDao,
  });

  @override
  Future<List<PackManifestItem>> fetchAvailablePacks() async {
    try {
      final jsonString = await rootBundle.loadString('assets/quran/mock_manifest.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final manifest = PackManifest.fromJson(jsonMap);
      return manifest.packs;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> isPackDownloaded(String packId) async {
    final pack = await packDao.getPackById(packId);
    return pack?.downloaded ?? false;
  }

  @override
  Future<void> importTranslationPack({
    required PackManifestItem packMeta,
    required List<Map<String, dynamic>> translationData,
  }) async {
    await db.transaction(() async {
      // 1. Insert Translation Meta
      await db.into(db.translationsMeta).insertOnConflictUpdate(
            TranslationsMetaCompanion.insert(
              translationId: packMeta.packId,
              language: 'en',
              translatorName: packMeta.name,
              source: packMeta.downloadUrl,
              licenseNote: packMeta.licenseNote,
            ),
          );

      // 2. Insert Ayah Translations
      for (final item in translationData) {
        await db.into(db.ayahTranslations).insertOnConflictUpdate(
              AyahTranslationsCompanion.insert(
                translationId: packMeta.packId,
                surahNumber: item['surah_number'] as int,
                ayahNumber: item['ayah_number'] as int,
                textContent: item['text'] as String,
              ),
            );
      }

      // 3. Mark pack as downloaded in database
      await packDao.upsertPack(
        ContentPacksCompanion.insert(
          packId: packMeta.packId,
          type: packMeta.type,
          name: packMeta.name,
          version: packMeta.version,
          downloaded: const Value(true),
          downloadUrl: packMeta.downloadUrl,
          sizeBytes: packMeta.sizeBytes,
          licenseNote: packMeta.licenseNote,
        ),
      );

      // 4. Register in FTS index
      await FtsSetup.indexTranslationFts(
        executor: db.executor,
        translationId: packMeta.packId,
      );
    });
  }

  @override
  Future<void> removePack(String packId) async {
    await packDao.markAsDeleted(packId);
  }
}
