import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_database.dart';
import 'daos/quran_dao.dart';
import 'daos/search_dao.dart';
import 'daos/content_pack_dao.dart';
import '../content_packs/repositories/content_pack_repository.dart';
import '../content_packs/models/pack_manifest.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final quranDaoProvider = Provider<QuranDao>((ref) {
  return ref.watch(databaseProvider).quranDao;
});

final searchDaoProvider = Provider<SearchDao>((ref) {
  return ref.watch(databaseProvider).searchDao;
});

final contentPackDaoProvider = Provider<ContentPackDao>((ref) {
  return ref.watch(databaseProvider).contentPackDao;
});

final contentPackRepositoryProvider = Provider<ContentPackRepository>((ref) {
  return ContentPackRepositoryImpl(
    db: ref.watch(databaseProvider),
    packDao: ref.watch(contentPackDaoProvider),
  );
});

// --- Query Providers ---

final surahsProvider = FutureProvider<List<Surah>>((ref) async {
  final dao = ref.watch(quranDaoProvider);
  return dao.getAllSurahs();
});

final surahDetailProvider = FutureProvider.family<List<AyahWithTranslation>, int>((ref, surahNumber) async {
  final dao = ref.watch(quranDaoProvider);
  return dao.getAyahsForSurah(surahNumber: surahNumber);
});

final arabicSearchProvider = FutureProvider.family<List<FtsSearchResult>, String>((ref, query) async {
  final searchDao = ref.watch(searchDaoProvider);
  return searchDao.searchArabic(query);
});

final translationSearchProvider = FutureProvider.family<List<FtsSearchResult>, String>((ref, query) async {
  final searchDao = ref.watch(searchDaoProvider);
  return searchDao.searchTranslation(query: query);
});

final availableContentPacksProvider = FutureProvider<List<PackManifestItem>>((ref) async {
  final repo = ref.watch(contentPackRepositoryProvider);
  return repo.fetchAvailablePacks();
});
