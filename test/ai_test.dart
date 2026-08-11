import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:studyquran/core/database/app_database.dart';
import 'package:studyquran/core/database/daos/ai_history_dao.dart';
import 'package:studyquran/features/ai_assistant/domain/secure_key_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase db;
  late AiHistoryDao aiHistoryDao;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    aiHistoryDao = db.aiHistoryDao;
  });

  tearDown(() async {
    await db.close();
  });

  test('AiHistoryDao saves and retrieves local AI research entries correctly', () async {
    await aiHistoryDao.saveAiHistory(
      sessionType: 'explain',
      contextLabel: 'Al-Fatihah (1:1)',
      promptSent: 'Explain verse 1:1',
      responseReceived: 'In-depth linguistic explanation of Bismillah...',
    );

    final history = await aiHistoryDao.getAiHistoryForContext('Al-Fatihah (1:1)');
    expect(history.length, equals(1));
    expect(history.first.contextLabel, equals('Al-Fatihah (1:1)'));
    expect(history.first.responseReceived, contains('Bismillah'));

    final allHistory = await aiHistoryDao.getAllAiHistory();
    expect(allHistory.length, equals(1));

    await aiHistoryDao.clearAiHistory();
    final clearedHistory = await aiHistoryDao.getAllAiHistory();
    expect(clearedHistory.isEmpty, isTrue);
  });
}
