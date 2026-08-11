// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thematic_dao.dart';

// ignore_for_file: type=lint
mixin _$ThematicDaoMixin on DatabaseAccessor<AppDatabase> {
  $SurahsTable get surahs => attachedDatabase.surahs;
  $AyahsTable get ayahs => attachedDatabase.ayahs;
  $AyahTranslationsTable get ayahTranslations =>
      attachedDatabase.ayahTranslations;
  $TopicsTable get topics => attachedDatabase.topics;
  $TopicAyahsTable get topicAyahs => attachedDatabase.topicAyahs;
  $CrossReferencesTable get crossReferences => attachedDatabase.crossReferences;
  $AsbabAlNuzulTable get asbabAlNuzul => attachedDatabase.asbabAlNuzul;
  ThematicDaoManager get managers => ThematicDaoManager(this);
}

class ThematicDaoManager {
  final _$ThematicDaoMixin _db;
  ThematicDaoManager(this._db);
  $$SurahsTableTableManager get surahs =>
      $$SurahsTableTableManager(_db.attachedDatabase, _db.surahs);
  $$AyahsTableTableManager get ayahs =>
      $$AyahsTableTableManager(_db.attachedDatabase, _db.ayahs);
  $$AyahTranslationsTableTableManager get ayahTranslations =>
      $$AyahTranslationsTableTableManager(
        _db.attachedDatabase,
        _db.ayahTranslations,
      );
  $$TopicsTableTableManager get topics =>
      $$TopicsTableTableManager(_db.attachedDatabase, _db.topics);
  $$TopicAyahsTableTableManager get topicAyahs =>
      $$TopicAyahsTableTableManager(_db.attachedDatabase, _db.topicAyahs);
  $$CrossReferencesTableTableManager get crossReferences =>
      $$CrossReferencesTableTableManager(
        _db.attachedDatabase,
        _db.crossReferences,
      );
  $$AsbabAlNuzulTableTableManager get asbabAlNuzul =>
      $$AsbabAlNuzulTableTableManager(_db.attachedDatabase, _db.asbabAlNuzul);
}
