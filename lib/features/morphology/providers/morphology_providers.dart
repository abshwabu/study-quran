import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/providers.dart';
import '../../../core/database/daos/quran_dao.dart';
import '../../../core/database/app_database.dart';

final wordsForAyahProvider = FutureProvider.family<List<WordWithRoot>, ({int surahNumber, int ayahNumber})>((ref, arg) async {
  final quranDao = ref.watch(quranDaoProvider);
  return quranDao.getWordsWithRootsForAyah(arg.surahNumber, arg.ayahNumber);
});

final rootBrowserQueryProvider = StateProvider<String>((ref) => '');

final rootsListProvider = FutureProvider<List<Root>>((ref) async {
  final query = ref.watch(rootBrowserQueryProvider);
  final quranDao = ref.watch(quranDaoProvider);
  return quranDao.searchRoots(query);
});
