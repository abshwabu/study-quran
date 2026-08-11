// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_dao.dart';

// ignore_for_file: type=lint
mixin _$WorkspaceDaoMixin on DatabaseAccessor<AppDatabase> {
  $SurahsTable get surahs => attachedDatabase.surahs;
  $AyahsTable get ayahs => attachedDatabase.ayahs;
  $AyahTranslationsTable get ayahTranslations =>
      attachedDatabase.ayahTranslations;
  $CollectionsTable get collections => attachedDatabase.collections;
  $BookmarksTable get bookmarks => attachedDatabase.bookmarks;
  $NotesTable get notes => attachedDatabase.notes;
  $TagsTable get tags => attachedDatabase.tags;
  $ItemTagsTable get itemTags => attachedDatabase.itemTags;
  WorkspaceDaoManager get managers => WorkspaceDaoManager(this);
}

class WorkspaceDaoManager {
  final _$WorkspaceDaoMixin _db;
  WorkspaceDaoManager(this._db);
  $$SurahsTableTableManager get surahs =>
      $$SurahsTableTableManager(_db.attachedDatabase, _db.surahs);
  $$AyahsTableTableManager get ayahs =>
      $$AyahsTableTableManager(_db.attachedDatabase, _db.ayahs);
  $$AyahTranslationsTableTableManager get ayahTranslations =>
      $$AyahTranslationsTableTableManager(
        _db.attachedDatabase,
        _db.ayahTranslations,
      );
  $$CollectionsTableTableManager get collections =>
      $$CollectionsTableTableManager(_db.attachedDatabase, _db.collections);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db.attachedDatabase, _db.bookmarks);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db.attachedDatabase, _db.notes);
  $$TagsTableTableManager get tags =>
      $$TagsTableTableManager(_db.attachedDatabase, _db.tags);
  $$ItemTagsTableTableManager get itemTags =>
      $$ItemTagsTableTableManager(_db.attachedDatabase, _db.itemTags);
}
