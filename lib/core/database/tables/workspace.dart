import 'package:drift/drift.dart';

@DataClassName('WorkspaceCollection')
class Collections extends Table {
  TextColumn get collectionId => text()();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {collectionId};
}

@DataClassName('Bookmark')
class Bookmarks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  TextColumn get collectionId => text().nullable().customConstraint('REFERENCES collections(collection_id)')();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('UserNote')
class Notes extends Table {
  TextColumn get noteId => text()();
  IntColumn get surahNumber => integer()();
  IntColumn get startAyah => integer()();
  IntColumn get endAyah => integer()();
  TextColumn get textContent => text().named('text_content')();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {noteId};
}

@DataClassName('WorkspaceTag')
class Tags extends Table {
  TextColumn get tagId => text()();
  TextColumn get name => text()();
  TextColumn get colorHex => text().withDefault(const Constant('#009688'))();

  @override
  Set<Column> get primaryKey => {tagId};
}

@DataClassName('ItemTag')
class ItemTags extends Table {
  TextColumn get itemType => text()(); // 'bookmark' or 'note'
  TextColumn get itemId => text()(); // bookmark ID string or noteId
  TextColumn get tagId => text().customConstraint('REFERENCES tags(tag_id) NOT NULL')();

  @override
  Set<Column> get primaryKey => {itemType, itemId, tagId};
}
