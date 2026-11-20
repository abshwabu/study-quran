import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/providers.dart';
import '../../../core/database/daos/tafsir_dao.dart';

final tafsirDaoProvider = Provider<TafsirDao>((ref) {
  return ref.watch(databaseProvider).tafsirDao;
});

final availableTafsirsMetaProvider = FutureProvider<List<TafsirMeta>>((ref) async {
  final dao = ref.watch(tafsirDaoProvider);
  return dao.getAllTafsirsMeta();
});

class DefaultTafsirNotifier extends StateNotifier<String> {
  DefaultTafsirNotifier() : super('ar.muyassar');

  void setDefaultTafsir(String id) {
    state = id;
  }
}

final defaultTafsirIdProvider =
    StateNotifierProvider<DefaultTafsirNotifier, String>((ref) {
  return DefaultTafsirNotifier();
});

typedef TafsirQueryParam = ({
  String tafsirId,
  int surahNumber,
  int ayahNumber,
});

final singleTafsirCommentaryProvider = FutureProvider.family<
    TafsirEntryWithMeta?, TafsirQueryParam>((ref, param) async {
  final dao = ref.watch(tafsirDaoProvider);
  return dao.getCommentaryForAyah(
    tafsirId: param.tafsirId,
    surahNumber: param.surahNumber,
    ayahNumber: param.ayahNumber,
  );
});

final downloadedTafsirIdsProvider = FutureProvider<List<String>>((ref) async {
  final dao = ref.watch(tafsirDaoProvider);
  return dao.getDownloadedTafsirIds();
});

class ComparisonQueryParam {
  final List<String> tafsirIds;
  final int surahNumber;
  final int ayahNumber;

  ComparisonQueryParam({
    required List<String> tafsirIds,
    required this.surahNumber,
    required this.ayahNumber,
  }) : tafsirIds = List.unmodifiable([...tafsirIds]..sort());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ComparisonQueryParam) return false;
    if (other.surahNumber != surahNumber || other.ayahNumber != ayahNumber) return false;
    if (other.tafsirIds.length != tafsirIds.length) return false;
    for (int i = 0; i < tafsirIds.length; i++) {
      if (other.tafsirIds[i] != tafsirIds[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(
        Object.hashAll(tafsirIds),
        surahNumber,
        ayahNumber,
      );
}

class TafsirComparisonItem {
  final String tafsirId;
  final TafsirMeta meta;
  final TafsirContentData? content;
  final bool isDownloaded;

  const TafsirComparisonItem({
    required this.tafsirId,
    required this.meta,
    this.content,
    required this.isDownloaded,
  });
}

final comparisonTafsirsProvider = FutureProvider.family<
    List<TafsirComparisonItem>, ComparisonQueryParam>((ref, param) async {
  final dao = ref.watch(tafsirDaoProvider);
  final downloadedIds = await dao.getDownloadedTafsirIds();
  final allMetas = await dao.getAllTafsirsMeta();
  final existingEntries = await dao.getTafsirsForAyahComparison(
    tafsirIds: param.tafsirIds,
    surahNumber: param.surahNumber,
    ayahNumber: param.ayahNumber,
  );

  final metaMap = {for (final m in allMetas) m.tafsirId: m};
  final entryMap = {for (final e in existingEntries) e.meta.tafsirId: e.content};

  return param.tafsirIds.map((id) {
    final meta = metaMap[id] ??
        TafsirMeta(
          tafsirId: id,
          name: id,
          author: 'Classical Scholar',
          language: id.startsWith('ar.') ? 'ar' : 'en',
          source: '',
          licenseNote: '',
        );
    final isDownloaded = downloadedIds.contains(id);
    final content = entryMap[id];

    return TafsirComparisonItem(
      tafsirId: id,
      meta: meta,
      content: content,
      isDownloaded: isDownloaded,
    );
  }).toList();
});
