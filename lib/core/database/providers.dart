import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/native.dart';
import 'app_database.dart';
import 'database_init_service.dart';
import 'daos/quran_dao.dart';
import 'daos/search_dao.dart';
import 'daos/content_pack_dao.dart';
import '../content_packs/repositories/content_pack_repository.dart';
import '../content_packs/models/pack_manifest.dart';

class DatabaseInitNotifier extends StateNotifier<DatabaseInitStatus> {
  DatabaseInitNotifier() : super(DatabaseInitStatus.initial()) {
    initialize();
  }

  AppDatabase? _dbInstance;

  AppDatabase get db {
    if (_dbInstance == null) {
      throw StateError('Database has not been initialized yet.');
    }
    return _dbInstance!;
  }

  Future<void> initialize() async {
    try {
      state = const DatabaseInitStatus(
        isReady: false,
        progress: 0.1,
        message: 'Loading Quran database...',
      );

      final dbFile = await DatabaseInitService.prepareDatabaseFile(
        onProgress: (progress, message) {
          state = DatabaseInitStatus(
            isReady: false,
            progress: progress,
            message: message,
          );
        },
      );

      _dbInstance = AppDatabase(NativeDatabase(dbFile));

      // Instantly mark ready
      state = const DatabaseInitStatus(
        isReady: true,
        progress: 1.0,
        message: 'Quran database ready!',
      );
    } catch (e) {
      state = DatabaseInitStatus(
        isReady: false,
        progress: 0.0,
        error: e.toString(),
        message: 'Database initialization error: $e',
      );
    }
  }

  void retry() {
    _dbInstance?.close();
    _dbInstance = null;
    state = DatabaseInitStatus.initial();
    initialize();
  }
}

final databaseInitProvider =
    StateNotifierProvider<DatabaseInitNotifier, DatabaseInitStatus>((ref) {
  return DatabaseInitNotifier();
});

final databaseProvider = Provider<AppDatabase>((ref) {
  final initStatus = ref.watch(databaseInitProvider);
  if (!initStatus.isReady) {
    throw StateError('Database is not ready yet');
  }
  return ref.watch(databaseInitProvider.notifier).db;
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
