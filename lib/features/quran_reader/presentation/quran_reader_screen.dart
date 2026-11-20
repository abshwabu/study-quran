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
import '../../settings/presentation/settings_screen.dart';

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

  void _toggleTheme(ThemeMode currentMode) {
    final nextMode = switch (currentMode) {
      ThemeMode.system => ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
    };
    ref.read(readerPreferencesProvider.notifier).updateThemeMode(nextMode);

    final modeName = switch (nextMode) {
      ThemeMode.system => 'Auto (System)',
      ThemeMode.light => 'Light Mode',
      ThemeMode.dark => 'Dark Mode',
    };

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Theme switched to $modeName'),
        duration: const Duration(milliseconds: 1400),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            '${activeSurah.number}. ${activeSurah.nameTranslit}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: colorScheme.secondary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            activeSurah.revelationPlace.toUpperCase(),
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${activeSurah.nameTranslation} • ${activeSurah.ayahCount} Ayahs',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
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
              // Theme switcher quick action
              IconButton(
                icon: Icon(
                  switch (prefs.themeMode) {
                    ThemeMode.system => Icons.brightness_auto,
                    ThemeMode.light => Icons.light_mode,
                    ThemeMode.dark => Icons.dark_mode,
                  },
                  color: colorScheme.primary,
                ),
                tooltip: 'Switch Theme (${prefs.themeMode.name})',
                onPressed: () => _toggleTheme(prefs.themeMode),
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
                    case 'settings':
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => const SettingsScreen()),
                      );
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'workspace',
                    child: Row(
                      children: [
                        Icon(Icons.workspaces_outline, color: colorScheme.primary),
                        const SizedBox(width: 12),
                        const Text('Research Workspace'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'topics',
                    child: Row(
                      children: [
                        Icon(Icons.category, color: colorScheme.primary),
                        const SizedBox(width: 12),
                        const Text('Thematic Topic Index'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'roots',
                    child: Row(
                      children: [
                        Icon(Icons.blur_on, color: colorScheme.primary),
                        const SizedBox(width: 12),
                        const Text('Root Word Browser'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'tafsir',
                    child: Row(
                      children: [
                        Icon(Icons.library_books, color: colorScheme.primary),
                        const SizedBox(width: 12),
                        const Text('Tafsir Library'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'ai',
                    child: Row(
                      children: [
                        Icon(Icons.auto_awesome, color: Colors.blue),
                        const SizedBox(width: 12),
                        const Text('AI Research Assistant'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'downloads',
                    child: Row(
                      children: [
                        Icon(Icons.download, color: colorScheme.secondary),
                        const SizedBox(width: 12),
                        const Text('Content Pack Downloader'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'settings',
                    child: Row(
                      children: [
                        Icon(Icons.settings_outlined, color: colorScheme.onSurfaceVariant),
                        const SizedBox(width: 12),
                        const Text('Settings & Preferences'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: ayahsAsync.when(
            loading: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: colorScheme.primary),
                  const SizedBox(height: 16),
                  Text('Loading Quran Database...', style: TextStyle(color: colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
            error: (err, stack) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: colorScheme.error),
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

                  // Modern Surah Footer Navigation Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
                    ),
                    child: SafeArea(
                      top: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton.icon(
                            onPressed: _currentSurahNumber > 1 ? () => _onSurahSelected(_currentSurahNumber - 1) : null,
                            icon: const Icon(Icons.arrow_back_ios_new, size: 14),
                            label: const Text('Previous'),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Surah $_currentSurahNumber / 114',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: _currentSurahNumber < 114 ? () => _onSurahSelected(_currentSurahNumber + 1) : null,
                            iconAlignment: IconAlignment.end,
                            icon: const Icon(Icons.arrow_forward_ios, size: 14),
                            label: const Text('Next'),
                          ),
                        ],
                      ),
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
