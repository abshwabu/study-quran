// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tafsir_dao.dart';

// ignore_for_file: type=lint
mixin _$TafsirDaoMixin on DatabaseAccessor<AppDatabase> {
  $TafsirsMetaTable get tafsirsMeta => attachedDatabase.tafsirsMeta;
  $TafsirContentTable get tafsirContent => attachedDatabase.tafsirContent;
  TafsirDaoManager get managers => TafsirDaoManager(this);
}

class TafsirDaoManager {
  final _$TafsirDaoMixin _db;
  TafsirDaoManager(this._db);
  $$TafsirsMetaTableTableManager get tafsirsMeta =>
      $$TafsirsMetaTableTableManager(_db.attachedDatabase, _db.tafsirsMeta);
  $$TafsirContentTableTableManager get tafsirContent =>
      $$TafsirContentTableTableManager(_db.attachedDatabase, _db.tafsirContent);
}
