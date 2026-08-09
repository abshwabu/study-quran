import 'package:drift/drift.dart';

@DataClassName('ContentPack')
class ContentPacks extends Table {
  TextColumn get packId => text()();
  TextColumn get type => text()(); // translation, tafsir, audio, morphology
  TextColumn get name => text()();
  TextColumn get version => text()();
  BoolColumn get downloaded => boolean().withDefault(const Constant(false))();
  TextColumn get downloadUrl => text()();
  IntColumn get sizeBytes => integer()();
  TextColumn get licenseNote => text()();

  @override
  Set<Column> get primaryKey => {packId};
}
