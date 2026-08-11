import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/secure_key_storage.dart';
import '../../../core/database/providers.dart';
import '../../../core/database/app_database.dart';

class ApiKeyNotifier extends StateNotifier<AsyncValue<String?>> {
  ApiKeyNotifier() : super(const AsyncValue.loading()) {
    loadKey();
  }

  Future<void> loadKey() async {
    try {
      final key = await SecureKeyStorage.getApiKey();
      state = AsyncValue.data(key);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> setKey(String key) async {
    await SecureKeyStorage.saveApiKey(key);
    state = AsyncValue.data(key);
  }

  Future<void> clearKey() async {
    await SecureKeyStorage.clearApiKey();
    state = const AsyncValue.data(null);
  }
}

final apiKeyProvider = StateNotifierProvider<ApiKeyNotifier, AsyncValue<String?>>((ref) {
  return ApiKeyNotifier();
});

final aiHistoryForContextProvider = FutureProvider.family<List<AiHistoryEntry>, String>((ref, contextLabel) async {
  final dao = ref.watch(aiHistoryDaoProvider);
  return dao.getAiHistoryForContext(contextLabel);
});

final allAiHistoryProvider = FutureProvider<List<AiHistoryEntry>>((ref) async {
  final dao = ref.watch(aiHistoryDaoProvider);
  return dao.getAllAiHistory();
});
