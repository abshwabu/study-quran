import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:studyquran/core/database/app_database.dart';
import 'package:studyquran/core/database/daos/workspace_dao.dart';
import 'package:studyquran/features/workspace/domain/citation_export_service.dart';
import 'package:studyquran/features/workspace/domain/workspace_backup_service.dart';

void main() {
  late AppDatabase db;
  late WorkspaceDao workspaceDao;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    workspaceDao = db.workspaceDao;

    // Seed mock Surah 1 & 2
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

    await db.into(db.surahs).insert(
          SurahsCompanion.insert(
            number: const Value(2),
            nameArabic: 'البقرة',
            nameTranslit: 'Al-Baqarah',
            nameTranslation: 'The Cow',
            revelationPlace: 'madinah',
            ayahCount: 286,
          ),
        );

    // Seed mock Ayahs
    await db.into(db.ayahs).insert(
          AyahsCompanion.insert(
            globalAyahIndex: const Value(1),
            surahNumber: 1,
            ayahNumber: 1,
            arabicTextUthmani: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
            juz: 1,
            page: 1,
          ),
        );

    await db.into(db.ayahs).insert(
          AyahsCompanion.insert(
            globalAyahIndex: const Value(10),
            surahNumber: 2,
            ayahNumber: 3,
            arabicTextUthmani: 'ٱلَّذِينَ يُؤْمِنُونَ بِٱلْغَيْبِ وَيُقِيمُونَ ٱلصَّلَاةَ وَمِمَّا رَزَقْنَاهُمْ يُنفِقُونَ',
            juz: 1,
            page: 2,
          ),
        );

    // Seed Translations
    await db.into(db.ayahTranslations).insert(
          AyahTranslationsCompanion.insert(
            translationId: 'en.saheeh',
            surahNumber: 1,
            ayahNumber: 1,
            textContent: 'In the name of Allah, the Entirely Merciful, the Especially Merciful.',
          ),
        );

    await db.into(db.ayahTranslations).insert(
          AyahTranslationsCompanion.insert(
            translationId: 'en.saheeh',
            surahNumber: 2,
            ayahNumber: 3,
            textContent: 'Who believe in the unseen, establish prayer, and spend out of what We have provided for them.',
          ),
        );
  });

  tearDown(() async {
    await db.close();
  });

  test('Bookmarking and note creation persists and queries correctly', () async {
    // 1. Add Bookmark
    await workspaceDao.addBookmark(surahNumber: 1, ayahNumber: 1);
    final isBookmarked = await workspaceDao.isAyahBookmarked(1, 1);
    expect(isBookmarked, isTrue);

    // 2. Add Note
    await workspaceDao.saveNote(
      noteId: 'n1',
      surahNumber: 1,
      startAyah: 1,
      endAyah: 1,
      textContent: 'Reflecting on the Opening invocation',
    );

    final notes = await workspaceDao.getNotes();
    expect(notes.length, equals(1));
    expect(notes.first.note.textContent, equals('Reflecting on the Opening invocation'));
  });

  test('Collections creation and bookmark filtering works', () async {
    await workspaceDao.createCollection(
      collectionId: 'col_patience',
      name: 'Verses on Patience',
      description: 'Research collection on Sabr',
    );

    final cols = await workspaceDao.getAllCollections();
    expect(cols.length, equals(1));
    expect(cols.first.name, equals('Verses on Patience'));

    await workspaceDao.addBookmark(surahNumber: 2, ayahNumber: 3, collectionId: 'col_patience');

    final colBookmarks = await workspaceDao.getBookmarks(collectionId: 'col_patience');
    expect(colBookmarks.length, equals(1));
    expect(colBookmarks.first.bookmark.surahNumber, equals(2));
    expect(colBookmarks.first.collection!.name, equals('Verses on Patience'));
  });

  test('CitationExportService formats single and batch collection citations in surah:ayah order', () async {
    await workspaceDao.addBookmark(surahNumber: 2, ayahNumber: 3);
    await workspaceDao.addBookmark(surahNumber: 1, ayahNumber: 1);

    final bookmarks = await workspaceDao.getBookmarks();
    final batchText = CitationExportService.formatBatchCitation(
      title: 'Test Batch',
      bookmarks: bookmarks,
    );

    expect(batchText, contains('Al-Fatihah (1:1)'));
    expect(batchText, contains('Al-Baqarah (2:3)'));

    // Verify Al-Fatihah (1:1) appears BEFORE Al-Baqarah (2:3) in exported text
    final posFatihah = batchText.indexOf('Al-Fatihah');
    final posBaqarah = batchText.indexOf('Al-Baqarah');
    expect(posFatihah < posBaqarah, isTrue);
  });

  test('WorkspaceBackupService round-trips JSON export and import without data loss', () async {
    // 1. Setup workspace state
    await workspaceDao.createCollection(collectionId: 'c1', name: 'Khutbah');
    await workspaceDao.addBookmark(surahNumber: 1, ayahNumber: 1, collectionId: 'c1');
    await workspaceDao.saveNote(
      noteId: 'n100',
      surahNumber: 1,
      startAyah: 1,
      endAyah: 1,
      textContent: 'Khutbah opening quote note',
    );

    // 2. Export JSON
    final jsonExport = await WorkspaceBackupService.exportToJson(db);
    expect(jsonExport, contains('Khutbah'));
    expect(jsonExport, contains('Khutbah opening quote note'));

    // 3. Import JSON back in
    await WorkspaceBackupService.importFromJson(db, jsonExport);

    // 4. Verify restored state
    final restoredCols = await workspaceDao.getAllCollections();
    expect(restoredCols.length, equals(1));
    expect(restoredCols.first.name, equals('Khutbah'));

    final restoredNotes = await workspaceDao.getNotes();
    expect(restoredNotes.length, equals(1));
    expect(restoredNotes.first.note.textContent, equals('Khutbah opening quote note'));
  });
}
