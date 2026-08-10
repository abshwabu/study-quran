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

typedef ComparisonQueryParam = ({
  List<String> tafsirIds,
  int surahNumber,
  int ayahNumber,
});

final comparisonTafsirsProvider = FutureProvider.family<
    List<TafsirEntryWithMeta>, ComparisonQueryParam>((ref, param) async {
  final dao = ref.watch(tafsirDaoProvider);
  return dao.getTafsirsForAyahComparison(
    tafsirIds: param.tafsirIds,
    surahNumber: param.surahNumber,
    ayahNumber: param.ayahNumber,
  );
});
