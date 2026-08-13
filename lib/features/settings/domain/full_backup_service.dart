import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/database/app_database.dart';
import '../../workspace/domain/workspace_backup_service.dart';

class RestoreResult {
  final bool success;
  final String message;
  final List<String> missingContentPacks;

  RestoreResult({
    required this.success,
    required this.message,
    this.missingContentPacks = const [],
  });
}

class FullBackupService {
  static const String _backupFormatVersion = '2.0';

  /// Export full app state (workspace data + app settings + installed content packs list)
  static Future<String> exportFullBackup(AppDatabase db) async {
    final prefs = await SharedPreferences.getInstance();

    // 1. Workspace Data
    final workspaceJsonStr = await WorkspaceBackupService.exportToJson(db);
    final workspaceData = json.decode(workspaceJsonStr) as Map<String, dynamic>;

    // 2. Installed Content Packs Manifest
    final installedPacks = await db.contentPackDao.watchDownloadedPacks().first;
    final installedPackIds = installedPacks.map((p) => p.packId).toList();

    // 3. App Settings
    final settingsMap = {
      'themeMode': prefs.getString('theme_mode') ?? 'system',
      'arabicFontSize': prefs.getDouble('arabic_font_size') ?? 24.0,
      'translationFontSize': prefs.getDouble('translation_font_size') ?? 15.0,
      'enableTajweed': prefs.getBool('enable_tajweed') ?? true,
      'readingMode': prefs.getString('reading_mode') ?? 'verseByVerse',
      'defaultTafsirId': prefs.getString('default_tafsir_id') ?? 'ar.muyassar',
      'wifiOnlyDownloads': prefs.getBool('wifi_only_downloads') ?? true,
    };

    final fullBackup = {
      'formatVersion': _backupFormatVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'workspace': workspaceData,
      'installedPacks': installedPackIds,
      'settings': settingsMap,
    };

    return const JsonEncoder.withIndent('  ').convert(fullBackup);
  }

  /// Restore full app state from JSON string
  static Future<RestoreResult> restoreFullBackup(AppDatabase db, String jsonString) async {
    try {
      final Map<String, dynamic> backupData = json.decode(jsonString) as Map<String, dynamic>;

      final formatVersion = backupData['formatVersion']?.toString() ?? '1.0';
      final prefs = await SharedPreferences.getInstance();

      // 1. Restore Workspace Data
      if (backupData['workspace'] != null) {
        final workspaceStr = json.encode(backupData['workspace']);
        await WorkspaceBackupService.importFromJson(db, workspaceStr);
      }

      // 2. Restore Settings
      if (backupData['settings'] != null) {
        final settings = backupData['settings'] as Map<String, dynamic>;
        if (settings['themeMode'] != null) await prefs.setString('theme_mode', settings['themeMode']);
        if (settings['arabicFontSize'] != null) await prefs.setDouble('arabic_font_size', (settings['arabicFontSize'] as num).toDouble());
        if (settings['translationFontSize'] != null) await prefs.setDouble('translation_font_size', (settings['translationFontSize'] as num).toDouble());
        if (settings['enableTajweed'] != null) await prefs.setBool('enable_tajweed', settings['enableTajweed']);
        if (settings['readingMode'] != null) await prefs.setString('reading_mode', settings['readingMode']);
        if (settings['defaultTafsirId'] != null) await prefs.setString('default_tafsir_id', settings['defaultTafsirId']);
        if (settings['wifiOnlyDownloads'] != null) await prefs.setBool('wifi_only_downloads', settings['wifiOnlyDownloads']);
      }

      // 3. Identify Missing Content Packs
      final List<String> installedPacksBackup = (backupData['installedPacks'] as List?)?.map((e) => e.toString()).toList() ?? [];
      final currentPacks = await db.contentPackDao.watchDownloadedPacks().first;
      final currentPackIds = currentPacks.map((p) => p.packId).toSet();

      final missingPacks = installedPacksBackup.where((id) => !currentPackIds.contains(id)).toList();

      return RestoreResult(
        success: true,
        message: 'Backup restored successfully! (Format v$formatVersion)',
        missingContentPacks: missingPacks,
      );
    } catch (e) {
      return RestoreResult(
        success: false,
        message: 'Failed to restore backup: $e',
      );
    }
  }
}
