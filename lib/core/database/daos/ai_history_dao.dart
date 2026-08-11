import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/ai_history.dart';

part 'ai_history_dao.g.dart';

@DriftAccessor(tables: [AiHistory])
class AiHistoryDao extends DatabaseAccessor<AppDatabase> with _$AiHistoryDaoMixin {
  AiHistoryDao(AppDatabase db) : super(db);

  Future<int> saveAiHistory({
    required String sessionType,
    required String contextLabel,
    required String promptSent,
    required String responseReceived,
  }) {
    return into(aiHistory).insert(
      AiHistoryCompanion.insert(
        sessionType: sessionType,
        contextLabel: contextLabel,
        promptSent: promptSent,
        responseReceived: responseReceived,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<List<AiHistoryEntry>> getAiHistoryForContext(String contextLabel) {
    return (select(aiHistory)
          ..where((a) => a.contextLabel.equals(contextLabel))
          ..orderBy([(a) => OrderingTerm.desc(a.createdAt)]))
        .get();
  }

  Future<List<AiHistoryEntry>> getAllAiHistory() {
    return (select(aiHistory)..orderBy([(a) => OrderingTerm.desc(a.createdAt)])).get();
  }

  Future<void> clearAiHistory() async {
    await delete(aiHistory).go();
  }
}
