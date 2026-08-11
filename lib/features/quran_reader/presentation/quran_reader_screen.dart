import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studyquran/core/database/providers.dart';
import 'package:studyquran/core/database/app_database.dart';
import '../domain/reader_preferences.dart';
import '../providers/reader_providers.dart';
import 'views/verse_by_verse_view.dart';
import 'views/continuous_scroll_view.dart';
import 'views/word_by_word_view.dart';
import 'widgets/surah_drawer.dart';
import 'widgets/jump_to_dialog.dart';
import 'widgets/reader_settings_modal.dart';
import 'widgets/database_loading_overlay.dart';
import 'widgets/ayah_actions_bottom_sheet.dart';
import '../../tafsir/presentation/tafsir_library_screen.dart';
import '../../search/presentation/search_screen.dart';
import '../../morphology/presentation/root_browser_screen.dart';
import '../../thematic/presentation/topic_browser_screen.dart';
import '../../workspace/presentation/workspace_screen.dart';
import '../../ai_assistant/presentation/ai_settings_screen.dart';
import '../../content_packs/presentation/content_pack_manager_screen.dart';





class QuranReaderScreen extends ConsumerStatefulWidget {
  const QuranReaderScreen({super.key});

  @override
  ConsumerState<QuranReaderScreen> createState() => _QuranReaderScreenState();
}

class _QuranReaderScreenState extends ConsumerState<QuranReaderScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  int _currentSurahNumber = 1;
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

  void _onSurahSelected(int surahNumber) {
    setState(() {
      _currentSurahNumber = surahNumber;
      _currentAyahNumber = 1;
    });
    ref.read(readerPreferencesProvider.notifier).saveLastReadPosition(surahNumber, 1);
  }

  void _jumpToAyah(int surahNumber, int ayahNumber) {
    setState(() {
      _currentSurahNumber = surahNumber;
      _currentAyahNumber = ayahNumber;
    });
    ref.read(readerPreferencesProvider.notifier).saveLastReadPosition(surahNumber, ayahNumber);
  }

  @override
  Widget build(BuildContext context) {
    final surahsAsync = ref.watch(surahsProvider);
    final ayahsAsync = ref.watch(surahDetailProvider(_currentSurahNumber));
    final prefs = ref.watch(readerPreferencesProvider);
    final dbInitStatus = ref.watch(databaseInitProvider);


    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          drawer: SurahDrawer(
            selectedSurahNumber: _currentSurahNumber,
            onSurahSelected: (surah) => _onSurahSelected(surah.number),
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
                icon: const Icon(Icons.search),
                tooltip: 'Search Quran & Concordance',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const SearchScreen(),
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
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                tooltip: 'More Research Tools',
                onSelected: (value) {
                  switch (value) {
                    case 'workspace':
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => const WorkspaceScreen()),
                      );
                      break;
                    case 'topics':
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => const TopicBrowserScreen()),
                      );
                      break;
                    case 'roots':
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => const RootBrowserScreen()),
                      );
                      break;
                    case 'tafsir':
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => const TafsirLibraryScreen()),
                      );
                      break;
                    case 'ai':
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => const AiSettingsScreen()),
                      );
                      break;
                    case 'downloads':
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => const ContentPackManagerScreen()),
                      );
                      break;
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'workspace',
                    child: Row(
                      children: [
                        Icon(Icons.workspaces_outline, color: Colors.teal),
                        SizedBox(width: 12),
                        Text('Research Workspace'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'topics',
                    child: Row(
                      children: [
                        Icon(Icons.category, color: Colors.teal),
                        SizedBox(width: 12),
                        Text('Thematic Topic Index'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'roots',
                    child: Row(
                      children: [
                        Icon(Icons.blur_on, color: Colors.teal),
                        SizedBox(width: 12),
                        Text('Root Word Browser'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'tafsir',
                    child: Row(
                      children: [
                        Icon(Icons.library_books, color: Colors.teal),
                        SizedBox(width: 12),
                        Text('Tafsir Library'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'ai',
                    child: Row(
                      children: [
                        Icon(Icons.auto_awesome, color: Colors.blue),
                        SizedBox(width: 12),
                        Text('AI Research Assistant'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'downloads',
                    child: Row(
                      children: [
                        Icon(Icons.download, color: Colors.orange),
                        SizedBox(width: 12),
                        Text('Content Pack Downloader'),
                      ],
                    ),
                  ),
                ],
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
                    child: prefs.readingMode == ReadingMode.wordByWord
                        ? WordByWordView(
                            ayahs: ayahsList,
                            preferences: prefs,
                            onAyahSelected: (ayahData) {
                              AyahActionsBottomSheet.show(
                                context,
                                ayahData: ayahData,
                                surahMeta: activeSurahMeta,
                              );
                            },
                          )
                        : prefs.readingMode == ReadingMode.verseByVerse
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

                  // Surah Footer Navigation Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: _currentSurahNumber > 1 ? () => _onSurahSelected(_currentSurahNumber - 1) : null,
                          icon: const Icon(Icons.arrow_back, size: 16),
                          label: const Text('Previous Surah'),
                        ),
                        Text(
                          'Surah $_currentSurahNumber / 114',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        TextButton.icon(
                          onPressed: _currentSurahNumber < 114 ? () => _onSurahSelected(_currentSurahNumber + 1) : null,
                          icon: const Icon(Icons.arrow_forward, size: 16),
                          label: const Text('Next Surah'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        // Non-blocking Database Loading Overlay
        if (!dbInitStatus.isReady)
          const DatabaseLoadingOverlay(),
      ],
    );
  }
}
