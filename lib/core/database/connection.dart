import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'database_init_service.dart';

/// Opens the SQLite database connection using NativeDatabase.
/// On first launch, copies `assets/quran/core_bundle.db` into local storage.
LazyDatabase openConnection({Function(double progress, String message)? onProgress}) {
  return LazyDatabase(() async {
    final File dbFile = await DatabaseInitService.prepareDatabaseFile(
      onProgress: (progress, message) {
        if (onProgress != null) {
          onProgress(progress, message);
        }
      },
    );

    return NativeDatabase.createInBackground(dbFile);
  });
}
