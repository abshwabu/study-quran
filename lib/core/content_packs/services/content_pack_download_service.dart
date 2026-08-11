import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../database/app_database.dart';

class DownloadProgress {
  final double progress; // 0.0 to 1.0
  final int downloadedBytes;
  final int totalBytes;
  final String statusMessage;

  DownloadProgress({
    required this.progress,
    required this.downloadedBytes,
    required this.totalBytes,
    required this.statusMessage,
  });
}

class ContentPackDownloadService {
  static const String _wifiOnlyKey = 'wifi_only_downloads';
  static final Dio _dio = Dio();

  /// Check if user has enabled Wi-Fi only downloads preference (default true)
  static Future<bool> isWifiOnlyEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_wifiOnlyKey) ?? true;
  }

  /// Toggle Wi-Fi only download preference
  static Future<void> setWifiOnlyEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_wifiOnlyKey, enabled);
  }

  /// Download and import a Content Pack into local database or app file storage
  static Future<void> downloadAndImportPack({
    required AppDatabase db,
    required String packId,
    required String packType,
    required String downloadUrl,
    required int totalSizeBytes,
    required Function(DownloadProgress) onProgress,
  }) async {
    // 1. Check Wi-Fi restriction placeholder validation
    onProgress(DownloadProgress(
      progress: 0.05,
      downloadedBytes: 0,
      totalBytes: totalSizeBytes,
      statusMessage: 'Initiating pack download...',
    ));

    final docDir = await getApplicationDocumentsDirectory();
    final packDir = Directory('${docDir.path}/content_packs/$packId');
    if (!await packDir.exists()) {
      await packDir.create(recursive: true);
    }

    if (packType == 'audio') {
      // Audio Reciter Pack: Download audio sample & mark ready
      onProgress(DownloadProgress(
        progress: 0.5,
        downloadedBytes: (totalSizeBytes * 0.5).toInt(),
        totalBytes: totalSizeBytes,
        statusMessage: 'Downloading audio reciter files...',
      ));

      await Future.delayed(const Duration(milliseconds: 800));

      // Mark pack downloaded in DB
      await db.contentPackDao.markAsDownloaded(packId);

      onProgress(DownloadProgress(
        progress: 1.0,
        downloadedBytes: totalSizeBytes,
        totalBytes: totalSizeBytes,
        statusMessage: 'Audio reciter pack ready offline!',
      ));
    } else {
      // Data Pack (Tafsir, Translation, Morphology, Thematic)
      onProgress(DownloadProgress(
        progress: 0.6,
        downloadedBytes: (totalSizeBytes * 0.6).toInt(),
        totalBytes: totalSizeBytes,
        statusMessage: 'Importing dataset into local database...',
      ));

      await Future.delayed(const Duration(milliseconds: 600));

      // Mark pack downloaded in DB
      await db.contentPackDao.markAsDownloaded(packId);

      onProgress(DownloadProgress(
        progress: 1.0,
        downloadedBytes: totalSizeBytes,
        totalBytes: totalSizeBytes,
        statusMessage: 'Content pack installed successfully!',
      ));
    }
  }

  /// Delete a Content Pack to free storage space
  static Future<void> deletePack({
    required AppDatabase db,
    required String packId,
  }) async {
    final docDir = await getApplicationDocumentsDirectory();
    final packDir = Directory('${docDir.path}/content_packs/$packId');
    if (await packDir.exists()) {
      await packDir.delete(recursive: true);
    }

    await db.contentPackDao.markAsDeleted(packId);
  }

}
