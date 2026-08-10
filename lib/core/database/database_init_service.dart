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
  /// Fast database preparer.
  /// Copies bundled complete 7.1MB core_bundle.db directly to app storage if missing or outdated (< 3MB).
  static Future<File> prepareDatabaseFile({
    required Function(double progress, String statusMessage) onProgress,
  }) async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'quran_app.db'));

    // Check if file doesn't exist, is empty, or is an old placeholder (< 3MB)
    if (!await file.exists() || await file.length() < 3 * 1024 * 1024) {
      onProgress(0.3, 'Copying complete 6,236-verse Quran database...');
      final blob = await rootBundle.load('assets/quran/core_bundle.db');
      final bytes = blob.buffer.asUint8List(blob.offsetInBytes, blob.lengthInBytes);
      await file.writeAsBytes(bytes, flush: true);
    }

    onProgress(1.0, 'SQLite database ready!');
    return file;
  }
}
