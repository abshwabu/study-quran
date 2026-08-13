import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/surahs.dart';
import '../tables/ayahs.dart';
import '../tables/translations.dart';
import '../tables/thematic.dart';

part 'thematic_dao.g.dart';

class CrossReferenceWithAyah {
  final CrossReference crossRef;
  final String targetSurahNameTranslit;
  final String targetSurahNameArabic;
  final String targetArabicText;
  final String? targetTranslationText;

  CrossReferenceWithAyah({
    required this.crossRef,
    required this.targetSurahNameTranslit,
    required this.targetSurahNameArabic,
    required this.targetArabicText,
    this.targetTranslationText,
  });
}

class TopicAyahResult {
  final int surahNumber;
  final int ayahNumber;
  final String surahNameTranslit;
  final String surahNameArabic;
  final String arabicTextUthmani;
  final String? translationText;

  TopicAyahResult({
    required this.surahNumber,
    required this.ayahNumber,
    required this.surahNameTranslit,
    required this.surahNameArabic,
    required this.arabicTextUthmani,
    this.translationText,
  });
}

@DriftAccessor(tables: [Surahs, Ayahs, AyahTranslations, Topics, TopicAyahs, CrossReferences, AsbabAlNuzul])
class ThematicDao extends DatabaseAccessor<AppDatabase> with _$ThematicDaoMixin {
  ThematicDao(AppDatabase db) : super(db);

  /// Get root topics (parentTopicId is null)
  Future<List<Topic>> getRootTopics() {
    return (select(topics)..where((t) => t.parentTopicId.isNull())).get();
  }

  /// Get child topics for a given parent
  Future<List<Topic>> getChildTopics(String parentTopicId) {
    return (select(topics)..where((t) => t.parentTopicId.equals(parentTopicId))).get();
  }

  /// Search topics by keyword
  Future<List<Topic>> searchTopics(String query) {
    final clean = query.trim();
    if (clean.isEmpty) return select(topics).get();

    return (select(topics)..where((t) => t.name.contains(clean) | t.category.contains(clean))).get();
  }


  /// Fetch all Ayahs associated with a Topic
  Future<List<TopicAyahResult>> getAyahsForTopic(String topicId, {String translationId = 'en.saheeh'}) async {
    final sql = '''
      SELECT 
        ta.surah_number, 
        ta.ayah_number, 
        s.name_translit AS surah_translit,
        s.name_arabic AS surah_arabic,
        a.arabic_text_uthmani,
        t.text AS translation_text
      FROM topic_ayahs ta
      INNER JOIN surahs s ON s.number = ta.surah_number
      INNER JOIN ayahs a ON a.surah_number = ta.surah_number AND a.ayah_number = ta.ayah_number
      LEFT JOIN ayah_translations t ON t.translation_id = ? AND t.surah_number = ta.surah_number AND t.ayah_number = ta.ayah_number
      WHERE ta.topic_id = ? OR ta.topic_id IN (SELECT topic_id FROM topics WHERE parent_topic_id = ?)
      GROUP BY ta.surah_number, ta.ayah_number
      ORDER BY ta.surah_number, ta.ayah_number;
    ''';

    final rows = await customSelect(
      sql,
      variables: [
        Variable.withString(translationId),
        Variable.withString(topicId),
        Variable.withString(topicId),
      ],
    ).get();


    return rows.map((row) {
      return TopicAyahResult(
        surahNumber: row.read<int>('surah_number'),
        ayahNumber: row.read<int>('ayah_number'),
        surahNameTranslit: row.read<String>('surah_translit'),
        surahNameArabic: row.read<String>('surah_arabic'),
        arabicTextUthmani: row.read<String>('arabic_text_uthmani'),
        translationText: row.read<String?>('translation_text'),
      );
    }).toList();
  }

  /// Fetch Cross References for a given Ayah
  Future<List<CrossReferenceWithAyah>> getCrossReferencesForAyah({
    required int surahNumber,
    required int ayahNumber,
    String translationId = 'en.saheeh',
  }) async {
    final sql = '''
      SELECT 
        c.id, c.source_surah, c.source_ayah, c.target_surah, c.target_ayah, c.relationship_type, c.notes,
        s.name_translit AS target_surah_translit,
        s.name_arabic AS target_surah_arabic,
        a.arabic_text_uthmani AS target_arabic_text,
        t.text AS target_translation_text
      FROM cross_references c
      INNER JOIN surahs s ON s.number = c.target_surah
      INNER JOIN ayahs a ON a.surah_number = c.target_surah AND a.ayah_number = c.target_ayah
      LEFT JOIN ayah_translations t ON t.translation_id = ? AND t.surah_number = c.target_surah AND t.ayah_number = c.target_ayah
      WHERE (c.source_surah = ? AND c.source_ayah = ?) OR (c.target_surah = ? AND c.target_ayah = ?)
      ORDER BY c.relationship_type, c.target_surah, c.target_ayah;
    ''';

    final rows = await customSelect(
      sql,
      variables: [
        Variable.withString(translationId),
        Variable.withInt(surahNumber),
        Variable.withInt(ayahNumber),
        Variable.withInt(surahNumber),
        Variable.withInt(ayahNumber),
      ],
    ).get();

    return rows.map((row) {
      return CrossReferenceWithAyah(
        crossRef: CrossReference(
          id: row.read<int>('id'),
          sourceSurah: row.read<int>('source_surah'),
          sourceAyah: row.read<int>('source_ayah'),
          targetSurah: row.read<int>('target_surah'),
          targetAyah: row.read<int>('target_ayah'),
          relationshipType: row.read<String>('relationship_type'),
          notes: row.read<String>('notes'),
        ),
        targetSurahNameTranslit: row.read<String>('target_surah_translit'),
        targetSurahNameArabic: row.read<String>('target_surah_arabic'),
        targetArabicText: row.read<String>('target_arabic_text'),
        targetTranslationText: row.read<String?>('target_translation_text'),
      );
    }).toList();
  }

  /// Fetch Asbab al-Nuzul entry for a given Ayah
  Future<AsbabAlNuzulEntry?> getAsbabAlNuzulForAyah({
    required int surahNumber,
    required int ayahNumber,
  }) async {
    return (select(asbabAlNuzul)
          ..where((a) =>
              a.surahNumber.equals(surahNumber) &
              a.startAyah.isSmallerOrEqualValue(ayahNumber) &
              a.endAyah.isBiggerOrEqualValue(ayahNumber)))
        .getSingleOrNull();
  }
}
