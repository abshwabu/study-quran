import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Opens the SQLite database connection using NativeDatabase.
/// On first launch, copies `assets/quran/core_bundle.db` into local storage.
LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'quran_app.db'));

    if (!await file.exists()) {
      try {
        final blob = await rootBundle.load('assets/quran/core_bundle.db');
        final bytes = blob.buffer.asUint8List(blob.offsetInBytes, blob.lengthInBytes);
        await file.writeAsBytes(bytes, flush: true);
      } catch (e) {
        // Fallback: If asset loading fails (e.g. unit tests), file is created fresh
      }
    }

    return NativeDatabase.createInBackground(file);
  });
}
