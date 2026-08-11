// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_history_dao.dart';

// ignore_for_file: type=lint
mixin _$AiHistoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $AiHistoryTable get aiHistory => attachedDatabase.aiHistory;
  AiHistoryDaoManager get managers => AiHistoryDaoManager(this);
}

class AiHistoryDaoManager {
  final _$AiHistoryDaoMixin _db;
  AiHistoryDaoManager(this._db);
  $$AiHistoryTableTableManager get aiHistory =>
      $$AiHistoryTableTableManager(_db.attachedDatabase, _db.aiHistory);
}
