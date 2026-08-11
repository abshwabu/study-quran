import 'package:drift/drift.dart';

@DataClassName('Topic')
class Topics extends Table {
  TextColumn get topicId => text()();
  TextColumn get name => text()();
  TextColumn get parentTopicId => text().nullable()();
  TextColumn get category => text().withDefault(const Constant('General'))();

  @override
  Set<Column> get primaryKey => {topicId};
}

@DataClassName('TopicAyah')
class TopicAyahs extends Table {
  TextColumn get topicId => text().customConstraint('REFERENCES topics(topic_id) NOT NULL')();

  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();

  @override
  Set<Column> get primaryKey => {topicId, surahNumber, ayahNumber};
}

@DataClassName('CrossReference')
class CrossReferences extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sourceSurah => integer()();
  IntColumn get sourceAyah => integer()();
  IntColumn get targetSurah => integer()();
  IntColumn get targetAyah => integer()();
  TextColumn get relationshipType => text()(); // e.g. 'similar_theme', 'same_story', 'similar_wording', 'scholarly_abrogation_naskh'
  TextColumn get notes => text().withDefault(const Constant(''))();
}

@DataClassName('AsbabAlNuzulEntry')
class AsbabAlNuzul extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get surahNumber => integer()();
  IntColumn get startAyah => integer()();
  IntColumn get endAyah => integer()();
  TextColumn get textContent => text().named('text_content')();
  TextColumn get sourceNote => text()();
}
