import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studyquran/core/database/app_database.dart';
import 'package:studyquran/core/content_packs/repositories/content_pack_repository.dart';
import 'package:studyquran/features/audio/domain/audio_player_service.dart';
import 'package:studyquran/core/content_packs/services/content_pack_download_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    const channel = MethodChannel('plugins.flutter.io/path_provider');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      return '.';
    });
  });

  test('AudioPlayerService configures speed and toggle repeat mode', () async {
    AudioPlayerService.toggleRepeatAyah();
    expect(AudioPlayerService.player, isNotNull);
  });

  test('ContentPackDownloadService manages Wi-Fi preference setting', () async {
    await ContentPackDownloadService.setWifiOnlyEnabled(true);
    final wifiEnabled = await ContentPackDownloadService.isWifiOnlyEnabled();
    expect(wifiEnabled, isTrue);

    await ContentPackDownloadService.setWifiOnlyEnabled(false);
    final wifiDisabled = await ContentPackDownloadService.isWifiOnlyEnabled();
    expect(wifiDisabled, isFalse);
  });

  test('Content pack download, install records and deletion lifecycle', () async {
    final db = AppDatabase(NativeDatabase.memory());
    final repo = ContentPackRepositoryImpl(db: db, packDao: db.contentPackDao);

    // Initial check from manifest/db
    final packs = await repo.fetchAvailablePacks();
    expect(packs, isNotEmpty);

    // Download Tafsir Ibn Kathir
    await ContentPackDownloadService.downloadAndImportPack(
      db: db,
      packId: 'en.ibnkathir',
      packType: 'tafsir',
      downloadUrl: 'https://cdn.quran.com/tafsir/en.ibnkathir.json',
      totalSizeBytes: 12000000,
      onProgress: (_) {},
    );

    final isDownloaded = await repo.isPackDownloaded('en.ibnkathir');
    expect(isDownloaded, isTrue);

    final commentary = await db.tafsirDao.getCommentaryForAyah(
      tafsirId: 'en.ibnkathir',
      surahNumber: 1,
      ayahNumber: 1,
    );
    expect(commentary, isNotNull);
    expect(commentary!.content.textContent, contains('Bismillah'));

    // Delete pack
    await ContentPackDownloadService.deletePack(db: db, packId: 'en.ibnkathir');
    final isStillDownloaded = await repo.isPackDownloaded('en.ibnkathir');
    expect(isStillDownloaded, isFalse);

    final deletedCommentary = await db.tafsirDao.getCommentaryForAyah(
      tafsirId: 'en.ibnkathir',
      surahNumber: 1,
      ayahNumber: 1,
    );
    expect(deletedCommentary, isNull);

    await db.close();
  });
}
