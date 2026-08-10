import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyquran/core/database/providers.dart';
import 'package:studyquran/core/database/app_database.dart';
import '../domain/reader_preferences.dart';
import '../providers/reader_providers.dart';
import 'views/verse_by_verse_view.dart';
import 'views/continuous_scroll_view.dart';
import 'widgets/surah_drawer.dart';
import 'widgets/jump_to_dialog.dart';
import 'widgets/reader_settings_modal.dart';
import 'widgets/database_loading_overlay.dart';
import '../../tafsir/presentation/tafsir_library_screen.dart';


class QuranReaderScreen extends ConsumerStatefulWidget {
  const QuranReaderScreen({super.key});

  @override
  ConsumerState<QuranReaderScreen> createState() => _QuranReaderScreenState();
}

class _QuranReaderScreenState extends ConsumerState<QuranReaderScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  late int _currentSurahNumber;
  int _currentAyahNumber = 1;

  @override
  void initState() {
    super.initState();
    final prefs = ref.read(readerPreferencesProvider);
    _currentSurahNumber = prefs.lastReadSurah;
    _currentAyahNumber = prefs.lastReadAyah;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onSurahSelected(Surah surah) {
    setState(() {
      _currentSurahNumber = surah.number;
      _currentAyahNumber = 1;
    });
    ref.read(readerPreferencesProvider.notifier).saveLastReadPosition(surah.number, 1);
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  void _jumpToAyah(int surahNumber, int ayahNumber) {
    setState(() {
      _currentSurahNumber = surahNumber;
      _currentAyahNumber = ayahNumber;
    });
    ref.read(readerPreferencesProvider.notifier).saveLastReadPosition(surahNumber, ayahNumber);
  }

  void _navigateToSurah(int direction) {
    final nextSurah = (_currentSurahNumber + direction).clamp(1, 114);
    if (nextSurah != _currentSurahNumber) {
      setState(() {
        _currentSurahNumber = nextSurah;
        _currentAyahNumber = 1;
      });
      ref.read(readerPreferencesProvider.notifier).saveLastReadPosition(nextSurah, 1);
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final initStatus = ref.watch(databaseInitProvider);

    if (!initStatus.isReady) {
      return const DatabaseLoadingOverlay();
    }

    final prefs = ref.watch(readerPreferencesProvider);
    final surahsAsync = ref.watch(surahsProvider);
    final ayahsAsync = ref.watch(surahDetailProvider(_currentSurahNumber));

    return Scaffold(
      key: _scaffoldKey,
      drawer: SurahDrawer(
        selectedSurahNumber: _currentSurahNumber,
        onSurahSelected: _onSurahSelected,
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Surah Index',
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: surahsAsync.when(
          loading: () => const Text('Loading...'),
          error: (_, __) => Text('Surah $_currentSurahNumber'),
          data: (surahs) {
            final activeSurah = surahs.firstWhere(
              (s) => s.number == _currentSurahNumber,
              orElse: () => surahs.first,
            );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${activeSurah.number}. ${activeSurah.nameTranslit}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${activeSurah.nameTranslation} • ${activeSurah.ayahCount} Ayahs',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.library_books),
            tooltip: 'Tafsir Library',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const TafsirLibraryScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.explore_outlined),
            tooltip: 'Jump to Ayah',
            onPressed: () => JumpToDialog.show(
              context,
              initialSurah: _currentSurahNumber,
              initialAyah: _currentAyahNumber,
              onJump: _jumpToAyah,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            tooltip: 'Reader Preferences',
            onPressed: () => ReaderSettingsModal.show(context),
          ),

        ],
      ),
      body: ayahsAsync.when(
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading Quran Database...', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Failed to load Quran text:\n$err',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    ref.invalidate(surahsProvider);
                    ref.invalidate(surahDetailProvider(_currentSurahNumber));
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry Loading'),
                ),
              ],
            ),
          ),
        ),
        data: (ayahsList) {
          if (ayahsList.isEmpty) {
            return const Center(child: Text('No ayahs available for this Surah.'));
          }

          final activeSurahMeta = surahsAsync.value?.firstWhere(
                (s) => s.number == _currentSurahNumber,
                orElse: () => Surah(
                  number: _currentSurahNumber,
                  nameArabic: '',
                  nameTranslit: 'Surah $_currentSurahNumber',
                  nameTranslation: '',
                  revelationPlace: 'makkah',
                  ayahCount: ayahsList.length,
                ),
              ) ??
              Surah(
                number: _currentSurahNumber,
                nameArabic: '',
                nameTranslit: 'Surah $_currentSurahNumber',
                nameTranslation: '',
                revelationPlace: 'makkah',
                ayahCount: ayahsList.length,
              );

          return Column(
            children: [
              Expanded(
                child: prefs.readingMode == ReadingMode.verseByVerse
                    ? VerseByVerseView(
                        ayahs: ayahsList,
                        surahMeta: activeSurahMeta,
                        prefs: prefs,
                        scrollController: _scrollController,
                        onAyahVisible: (ayahNum) {
                          _currentAyahNumber = ayahNum;
                        },
                      )
                    : ContinuousScrollView(
                        ayahs: ayahsList,
                        surahMeta: activeSurahMeta,
                        prefs: prefs,
                        scrollController: _scrollController,
                      ),
              ),

              // Surah Footer Navigation
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextButton.icon(
                        onPressed: _currentSurahNumber > 1 ? () => _navigateToSurah(-1) : null,
                        icon: const Icon(Icons.arrow_back, size: 18),
                        label: const Text('Prev', overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        '$_currentSurahNumber / 114',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                    Flexible(
                      child: TextButton.icon(
                        onPressed: _currentSurahNumber < 114 ? () => _navigateToSurah(1) : null,
                        icon: const Icon(Icons.arrow_forward, size: 18),
                        label: const Text('Next', overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
