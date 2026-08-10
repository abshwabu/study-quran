import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class DatabaseInitStatus {
  final bool isReady;
  final double progress; // 0.0 to 1.0
  final String message;
  final String? error;

  const DatabaseInitStatus({
    required this.isReady,
    required this.progress,
    required this.message,
    this.error,
  });

  factory DatabaseInitStatus.initial() {
    return const DatabaseInitStatus(
      isReady: false,
      progress: 0.0,
      message: 'Initializing system...',
    );
  }

  DatabaseInitStatus copyWith({
    bool? isReady,
    double? progress,
    String? message,
    String? error,
  }) {
    return DatabaseInitStatus(
      isReady: isReady ?? this.isReady,
      progress: progress ?? this.progress,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}

class DatabaseInitService {
  /// Prepares the local SQLite database file from bundled core_bundle.db asset.
  /// Automatically updates database if missing, corrupted, or size mismatch occurs.
  static Future<File> prepareDatabaseFile({
    required Function(double progress, String statusMessage) onProgress,
  }) async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'quran_app.db'));

    onProgress(0.2, 'Verifying local Quran & Tafsir database...');
    final blob = await rootBundle.load('assets/quran/core_bundle.db');
    final assetBytes = blob.lengthInBytes;

    bool needsCopy = false;
    if (!await file.exists() || await file.length() == 0) {
      needsCopy = true;
    } else {
      final currentSize = await file.length();
      // If disk database size is different from bundled asset size (e.g. upgraded schema/data), overwrite
      if (currentSize != assetBytes) {
        needsCopy = true;
      }
    }

    if (needsCopy) {
      onProgress(0.4, 'Updating database asset to storage...');
      final bytes = blob.buffer.asUint8List(blob.offsetInBytes, blob.lengthInBytes);
      await file.writeAsBytes(bytes, flush: true);
    }

    onProgress(1.0, 'SQLite database ready!');
    return file;
  }
}
