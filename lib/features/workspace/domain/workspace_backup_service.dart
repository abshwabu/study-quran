import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';

class WorkspaceBackupService {
  /// Export all local workspace data (collections, bookmarks, notes, tags, itemTags) into JSON string
  static Future<String> exportToJson(AppDatabase db) async {
    final dao = db.workspaceDao;

    final collections = await dao.getAllCollections();
    final bookmarks = await db.select(db.bookmarks).get();
    final notes = await db.select(db.notes).get();
    final tags = await dao.getAllTags();
    final itemTags = await db.select(db.itemTags).get();

    final dataMap = {
      'version': '1.0',
      'exportedAt': DateTime.now().toIso8601String(),
      'collections': collections
          .map((c) => {
                'collectionId': c.collectionId,
                'name': c.name,
                'description': c.description,
                'createdAt': c.createdAt.toIso8601String(),
              })
          .toList(),
      'bookmarks': bookmarks
          .map((b) => {
                'id': b.id,
                'surahNumber': b.surahNumber,
                'ayahNumber': b.ayahNumber,
                'collectionId': b.collectionId,
                'createdAt': b.createdAt.toIso8601String(),
              })
          .toList(),
      'notes': notes
          .map((n) => {
                'noteId': n.noteId,
                'surahNumber': n.surahNumber,
                'startAyah': n.startAyah,
                'endAyah': n.endAyah,
                'textContent': n.textContent,
                'createdAt': n.createdAt.toIso8601String(),
                'updatedAt': n.updatedAt.toIso8601String(),
              })
          .toList(),
      'tags': tags
          .map((t) => {
                'tagId': t.tagId,
                'name': t.name,
                'colorHex': t.colorHex,
              })
          .toList(),
      'itemTags': itemTags
          .map((it) => {
                'itemType': it.itemType,
                'itemId': it.itemId,
                'tagId': it.tagId,
              })
          .toList(),
    };

    return const JsonEncoder.withIndent('  ').convert(dataMap);
  }

  /// Import workspace data from JSON string, round-tripping into database
  static Future<void> importFromJson(AppDatabase db, String jsonString) async {
    final Map<String, dynamic> dataMap = json.decode(jsonString) as Map<String, dynamic>;

    await db.transaction(() async {
      // Clear existing user workspace data
      await db.delete(db.itemTags).go();
      await db.delete(db.bookmarks).go();
      await db.delete(db.notes).go();
      await db.delete(db.tags).go();
      await db.delete(db.collections).go();

      // 1. Import Collections
      if (dataMap['collections'] != null) {
        for (final item in (dataMap['collections'] as List)) {
          await db.into(db.collections).insert(
                CollectionsCompanion.insert(
                  collectionId: item['collectionId'],
                  name: item['name'],
                  description: Value(item['description'] ?? ''),
                  createdAt: DateTime.parse(item['createdAt']),
                ),
              );
        }
      }

      // 2. Import Bookmarks
      if (dataMap['bookmarks'] != null) {
        for (final item in (dataMap['bookmarks'] as List)) {
          await db.into(db.bookmarks).insert(
                BookmarksCompanion.insert(
                  surahNumber: item['surahNumber'],
                  ayahNumber: item['ayahNumber'],
                  collectionId: Value(item['collectionId']),
                  createdAt: DateTime.parse(item['createdAt']),
                ),
              );
        }
      }

      // 3. Import Notes
      if (dataMap['notes'] != null) {
        for (final item in (dataMap['notes'] as List)) {
          await db.into(db.notes).insert(
                NotesCompanion.insert(
                  noteId: item['noteId'],
                  surahNumber: item['surahNumber'],
                  startAyah: item['startAyah'],
                  endAyah: item['endAyah'],
                  textContent: item['textContent'],
                  createdAt: DateTime.parse(item['createdAt']),
                  updatedAt: DateTime.parse(item['updatedAt']),
                ),
              );
        }
      }

      // 4. Import Tags
      if (dataMap['tags'] != null) {
        for (final item in (dataMap['tags'] as List)) {
          await db.into(db.tags).insert(
                TagsCompanion.insert(
                  tagId: item['tagId'],
                  name: item['name'],
                  colorHex: Value(item['colorHex'] ?? '#009688'),
                ),
              );
        }
      }

      // 5. Import ItemTags
      if (dataMap['itemTags'] != null) {
        for (final item in (dataMap['itemTags'] as List)) {
          await db.into(db.itemTags).insert(
                ItemTagsCompanion.insert(
                  itemType: item['itemType'],
                  itemId: item['itemId'],
                  tagId: item['tagId'],
                ),
              );
        }
      }
    });
  }
}
