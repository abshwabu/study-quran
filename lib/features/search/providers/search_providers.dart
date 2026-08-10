import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/providers.dart';
import '../../../core/database/daos/search_dao.dart';
import '../domain/search_history.dart';

final searchQueryStateProvider = StateProvider<String>((ref) => '');

final searchFilterStateProvider = StateProvider<SearchFilter>((ref) {
  return const SearchFilter();
});

class SearchHistoryNotifier extends StateNotifier<AsyncValue<List<SearchHistoryItem>>> {
  SearchHistoryNotifier() : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    state = const AsyncValue.loading();
    try {
      final items = await SearchHistoryService.loadHistory();
      state = AsyncValue.data(items);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addQuery(String query, SearchFilter filter) async {
    await SearchHistoryService.saveQuery(query, filter);
    await load();
  }

  Future<void> togglePin(String query) async {
    await SearchHistoryService.togglePin(query);
    await load();
  }

  Future<void> clearHistory() async {
    await SearchHistoryService.clearHistory();
    await load();
  }
}

final searchHistoryNotifierProvider =
    StateNotifierProvider<SearchHistoryNotifier, AsyncValue<List<SearchHistoryItem>>>((ref) {
  return SearchHistoryNotifier();
});

final searchResultsProvider = FutureProvider<List<FtsSearchResult>>((ref) async {
  final query = ref.watch(searchQueryStateProvider);
  final filter = ref.watch(searchFilterStateProvider);

  if (query.trim().isEmpty) {
    return [];
  }

  final searchDao = ref.watch(searchDaoProvider);
  final results = await searchDao.searchCombined(
    query: query,
    filter: filter,
  );

  return results;
});

final rootConcordanceProvider = FutureProvider.family<List<RootOccurrenceResult>, String>((ref, rootArabic) async {
  final searchDao = ref.watch(searchDaoProvider);
  return searchDao.getConcordanceForRoot(rootArabic: rootArabic);
});
