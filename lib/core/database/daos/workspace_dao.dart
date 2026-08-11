import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/surahs.dart';
import '../tables/ayahs.dart';
import '../tables/translations.dart';
import '../tables/workspace.dart';

part 'workspace_dao.g.dart';

class BookmarkWithAyah {
  final Bookmark bookmark;
  final String surahNameTranslit;
  final String surahNameArabic;
  final String arabicTextUthmani;
  final String? translationText;
  final WorkspaceCollection? collection;

  BookmarkWithAyah({
    required this.bookmark,
    required this.surahNameTranslit,
    required this.surahNameArabic,
    required this.arabicTextUthmani,
    this.translationText,
    this.collection,
  });
}

class NoteWithAyah {
  final UserNote note;
  final String surahNameTranslit;
  final String surahNameArabic;
  final String arabicTextUthmani;
  final String? translationText;

  NoteWithAyah({
    required this.note,
    required this.surahNameTranslit,
    required this.surahNameArabic,
    required this.arabicTextUthmani,
    this.translationText,
  });
}

@DriftAccessor(tables: [Surahs, Ayahs, AyahTranslations, Collections, Bookmarks, Notes, Tags, ItemTags])
class WorkspaceDao extends DatabaseAccessor<AppDatabase> with _$WorkspaceDaoMixin {
  WorkspaceDao(AppDatabase db) : super(db);

  // --- Collections ---
  Future<List<WorkspaceCollection>> getAllCollections() {
    return (select(collections)..orderBy([(c) => OrderingTerm.asc(c.name)])).get();
  }

  Future<void> createCollection({
    required String collectionId,
    required String name,
    String description = '',
  }) {
    return into(collections).insert(
      CollectionsCompanion.insert(
        collectionId: collectionId,
        name: name,
        description: Value(description),
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> deleteCollection(String collectionId) async {
    await (update(bookmarks)..where((b) => b.collectionId.equals(collectionId)))
        .write(const BookmarksCompanion(collectionId: Value(null)));
    await (delete(collections)..where((c) => c.collectionId.equals(collectionId))).go();
  }

  // --- Bookmarks ---
  Future<bool> isAyahBookmarked(int surahNumber, int ayahNumber) async {
    final match = await (select(bookmarks)
          ..where((b) => b.surahNumber.equals(surahNumber) & b.ayahNumber.equals(ayahNumber)))
        .getSingleOrNull();
    return match != null;
  }

  Future<int> addBookmark({
    required int surahNumber,
    required int ayahNumber,
    String? collectionId,
  }) {
    return into(bookmarks).insert(
      BookmarksCompanion.insert(
        surahNumber: surahNumber,
        ayahNumber: ayahNumber,
        collectionId: Value(collectionId),
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> removeBookmark(int surahNumber, int ayahNumber) async {
    await (delete(bookmarks)
          ..where((b) => b.surahNumber.equals(surahNumber) & b.ayahNumber.equals(ayahNumber)))
        .go();
  }

  Future<List<BookmarkWithAyah>> getBookmarks({String? collectionId, String translationId = 'en.saheeh'}) async {
    final List<String> whereClauses = [];
    final List<Variable> variables = [Variable.withString(translationId)];

    if (collectionId != null) {
      whereClauses.add('b.collection_id = ?');
      variables.add(Variable.withString(collectionId));
    }

    final whereStr = whereClauses.isNotEmpty ? 'WHERE ${whereClauses.join(' AND ')}' : '';

    final sql = '''
      SELECT 
        b.id, b.surah_number, b.ayah_number, b.collection_id, b.created_at,
        s.name_translit AS surah_translit,
        s.name_arabic AS surah_arabic,
        a.arabic_text_uthmani,
        t.text AS translation_text,
        c.name AS collection_name, c.description AS collection_desc, c.created_at AS collection_created
      FROM bookmarks b
      INNER JOIN surahs s ON s.number = b.surah_number
      INNER JOIN ayahs a ON a.surah_number = b.surah_number AND a.ayah_number = b.ayah_number
      LEFT JOIN ayah_translations t ON t.translation_id = ? AND t.surah_number = b.surah_number AND t.ayah_number = b.ayah_number
      LEFT JOIN collections c ON c.collection_id = b.collection_id
      $whereStr
      ORDER BY b.surah_number, b.ayah_number;
    ''';

    final rows = await customSelect(sql, variables: variables).get();

    return rows.map((row) {
      final colId = row.read<String?>('collection_id');
      WorkspaceCollection? collectionObj;
      if (colId != null) {
        collectionObj = WorkspaceCollection(
          collectionId: colId,
          name: row.read<String>('collection_name'),
          description: row.read<String>('collection_desc'),
          createdAt: DateTime.parse(row.read<String>('collection_created')),
        );
      }

      return BookmarkWithAyah(
        bookmark: Bookmark(
          id: row.read<int>('id'),
          surahNumber: row.read<int>('surah_number'),
          ayahNumber: row.read<int>('ayah_number'),
          collectionId: colId,
          createdAt: DateTime.parse(row.read<String>('created_at')),
        ),
        surahNameTranslit: row.read<String>('surah_translit'),
        surahNameArabic: row.read<String>('surah_arabic'),
        arabicTextUthmani: row.read<String>('arabic_text_uthmani'),
        translationText: row.read<String?>('translation_text'),
        collection: collectionObj,
      );
    }).toList();
  }

  // --- Notes ---
  Future<void> saveNote({
    required String noteId,
    required int surahNumber,
    required int startAyah,
    required int endAyah,
    required String textContent,
  }) async {
    final now = DateTime.now();
    await into(notes).insertOnConflictUpdate(
      NotesCompanion.insert(
        noteId: noteId,
        surahNumber: surahNumber,
        startAyah: startAyah,
        endAyah: endAyah,
        textContent: textContent,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<void> deleteNote(String noteId) async {
    await (delete(itemTags)..where((it) => it.itemId.equals(noteId))).go();
    await (delete(notes)..where((n) => n.noteId.equals(noteId))).go();
  }

  Future<List<NoteWithAyah>> getNotes({String? searchQuery, String translationId = 'en.saheeh'}) async {
    final List<String> whereClauses = [];
    final List<Variable> variables = [Variable.withString(translationId)];

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      whereClauses.add('n.text_content LIKE ?');
      variables.add(Variable.withString('%${searchQuery.trim()}%'));
    }

    final whereStr = whereClauses.isNotEmpty ? 'WHERE ${whereClauses.join(' AND ')}' : '';

    final sql = '''
      SELECT 
        n.note_id, n.surah_number, n.start_ayah, n.end_ayah, n.text_content, n.created_at, n.updated_at,
        s.name_translit AS surah_translit,
        s.name_arabic AS surah_arabic,
        a.arabic_text_uthmani,
        t.text AS translation_text
      FROM notes n
      INNER JOIN surahs s ON s.number = n.surah_number
      INNER JOIN ayahs a ON a.surah_number = n.surah_number AND a.ayah_number = n.start_ayah
      LEFT JOIN ayah_translations t ON t.translation_id = ? AND t.surah_number = n.surah_number AND t.ayah_number = n.start_ayah
      $whereStr
      ORDER BY n.surah_number, n.start_ayah;
    ''';

    final rows = await customSelect(sql, variables: variables).get();

    return rows.map((row) {
      return NoteWithAyah(
        note: UserNote(
          noteId: row.read<String>('note_id'),
          surahNumber: row.read<int>('surah_number'),
          startAyah: row.read<int>('start_ayah'),
          endAyah: row.read<int>('end_ayah'),
          textContent: row.read<String>('text_content'),
          createdAt: DateTime.parse(row.read<String>('created_at')),
          updatedAt: DateTime.parse(row.read<String>('updated_at')),
        ),
        surahNameTranslit: row.read<String>('surah_translit'),
        surahNameArabic: row.read<String>('surah_arabic'),
        arabicTextUthmani: row.read<String>('arabic_text_uthmani'),
        translationText: row.read<String?>('translation_text'),
      );
    }).toList();
  }

  // --- Tags ---
  Future<List<WorkspaceTag>> getAllTags() {
    return (select(tags)..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
  }

  Future<void> createTag(String tagId, String name, String colorHex) {
    return into(tags).insert(
      TagsCompanion.insert(
        tagId: tagId,
        name: name,
        colorHex: Value(colorHex),
      ),
    );
  }

  Future<void> linkTagToItem(String itemType, String itemId, String tagId) {
    return into(itemTags).insertOnConflictUpdate(
      ItemTagsCompanion.insert(
        itemType: itemType,
        itemId: itemId,
        tagId: tagId,
      ),
    );
  }
}
