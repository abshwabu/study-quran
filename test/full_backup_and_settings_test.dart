import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studyquran/core/database/app_database.dart';
import 'package:studyquran/features/settings/domain/full_backup_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    db = AppDatabase(NativeDatabase.memory());

    // Seed mock Surah 1
    await db.into(db.surahs).insert(
          SurahsCompanion.insert(
            number: const Value(1),
            nameArabic: 'الفاتحة',
            nameTranslit: 'Al-Fatihah',
            nameTranslation: 'The Opening',
            revelationPlace: 'makkah',
            ayahCount: 7,
          ),
        );
  });

  tearDown(() async {
    await db.close();
  });

  test('FullBackupService exports format version 2.0 with settings and workspace data', () async {
    await db.workspaceDao.createCollection(collectionId: 'c1', name: 'Sabr Research');
    await db.workspaceDao.addBookmark(surahNumber: 1, ayahNumber: 1, collectionId: 'c1');

    final jsonBackup = await FullBackupService.exportFullBackup(db);

    expect(jsonBackup, contains('"formatVersion": "2.0"'));
    expect(jsonBackup, contains('Sabr Research'));
    expect(jsonBackup, contains('"settings"'));
    expect(jsonBackup, contains('"installedPacks"'));
  });

  test('FullBackupService restores workspace data and identifies missing content packs', () async {
    final mockBackupJson = '''
    {
      "formatVersion": "2.0",
      "exportedAt": "2026-08-13T00:00:00.000",
      "workspace": {
        "collections": [
          {
            "collectionId": "c_restored",
            "name": "Restored Collection",
            "description": "Test",
            "createdAt": "2026-08-13T00:00:00.000"
          }
        ],
        "bookmarks": [],
        "notes": [],
        "tags": [],
        "itemTags": []
      },
      "installedPacks": ["en.ibnkathir", "ar.tabari"],
      "settings": {
        "arabicFontSize": 28.0,
        "readingMode": "wordByWord"
      }
    }
    ''';

    final restoreResult = await FullBackupService.restoreFullBackup(db, mockBackupJson);

    expect(restoreResult.success, isTrue);
    expect(restoreResult.missingContentPacks, contains('en.ibnkathir'));
    expect(restoreResult.missingContentPacks, contains('ar.tabari'));

    final cols = await db.workspaceDao.getAllCollections();
    expect(cols.length, equals(1));
    expect(cols.first.name, equals('Restored Collection'));
  });
}
