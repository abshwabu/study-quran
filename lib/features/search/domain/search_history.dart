import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/database/daos/search_dao.dart';

class SearchHistoryItem {
  final String query;
  final SearchFilter filter;
  final DateTime timestamp;
  final bool isPinned;

  SearchHistoryItem({
    required this.query,
    this.filter = const SearchFilter(),
    required this.timestamp,
    this.isPinned = false,
  });

  Map<String, dynamic> toJson() => {
        'query': query,
        'surahNumber': filter.surahNumber,
        'juz': filter.juz,
        'revelationPlace': filter.revelationPlace,
        'targetScope': filter.targetScope,
        'timestamp': timestamp.toIso8601String(),
        'isPinned': isPinned,
      };

  factory SearchHistoryItem.fromJson(Map<String, dynamic> json) => SearchHistoryItem(
        query: json['query'] as String,
        filter: SearchFilter(
          surahNumber: json['surahNumber'] as int?,
          juz: json['juz'] as int?,
          revelationPlace: json['revelationPlace'] as String?,
          targetScope: (json['targetScope'] as String?) ?? 'all',
        ),
        timestamp: DateTime.parse(json['timestamp'] as String),
        isPinned: (json['isPinned'] as bool?) ?? false,
      );
}

class SearchHistoryService {
  static const String _keyHistory = 'quran_search_history_v1';

  static Future<List<SearchHistoryItem>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_keyHistory);
    if (jsonList == null) return [];

    try {
      return jsonList
          .map((item) => SearchHistoryItem.fromJson(json.decode(item) as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> saveQuery(String query, SearchFilter filter) async {
    if (query.trim().isEmpty) return;
    final items = await loadHistory();

    // Remove duplicates of same query
    items.removeWhere((i) => i.query.trim().toLowerCase() == query.trim().toLowerCase());

    // Insert at start
    items.insert(
      0,
      SearchHistoryItem(
        query: query.trim(),
        filter: filter,
        timestamp: DateTime.now(),
      ),
    );

    // Keep top 50 items
    if (items.length > 50) {
      items.removeRange(50, items.length);
    }

    final prefs = await SharedPreferences.getInstance();
    final jsonList = items.map((i) => json.encode(i.toJson())).toList();
    await prefs.setStringList(_keyHistory, jsonList);
  }

  static Future<void> togglePin(String query) async {
    final items = await loadHistory();
    for (int i = 0; i < items.length; i++) {
      if (items[i].query == query) {
        items[i] = SearchHistoryItem(
          query: items[i].query,
          filter: items[i].filter,
          timestamp: items[i].timestamp,
          isPinned: !items[i].isPinned,
        );
        break;
      }
    }

    final prefs = await SharedPreferences.getInstance();
    final jsonList = items.map((i) => json.encode(i.toJson())).toList();
    await prefs.setStringList(_keyHistory, jsonList);
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyHistory);
  }
}
