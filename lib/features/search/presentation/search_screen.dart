import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/providers.dart';
import '../providers/search_providers.dart';
import '../../quran_reader/presentation/quran_reader_screen.dart';
import 'root_concordance_screen.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: ref.read(searchQueryStateProvider));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String query) {
    if (query.trim().isNotEmpty) {
      ref.read(searchQueryStateProvider.notifier).state = query.trim();
      ref.read(searchHistoryNotifierProvider.notifier).addQuery(
            query.trim(),
            ref.read(searchFilterStateProvider),
          );
    }
  }

  void _openFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const _SearchFilterModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final query = ref.watch(searchQueryStateProvider);
    final filter = ref.watch(searchFilterStateProvider);
    final resultsAsync = ref.watch(searchResultsProvider);
    final historyAsync = ref.watch(searchHistoryNotifierProvider);
    final surahsAsync = ref.watch(surahsProvider);

    final surahName = (filter.surahNumber != null && surahsAsync.value != null)
        ? surahsAsync.value!.firstWhere((s) => s.number == filter.surahNumber).nameTranslit
        : null;

    final hasActiveFilter = filter.surahNumber != null || filter.juz != null || filter.revelationPlace != null || filter.targetScope != 'all';

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: false,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Search Quran text or translation...',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            contentPadding: EdgeInsets.zero,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      ref.read(searchQueryStateProvider.notifier).state = '';
                    },
                  )
                : null,
          ),
          onSubmitted: _onSearchSubmitted,
          onChanged: (val) {
            setState(() {});
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.tune,
              color: hasActiveFilter ? colorScheme.primary : null,
            ),
            tooltip: 'Search Filters & Scope',
            onPressed: _openFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Scope Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              border: Border(bottom: BorderSide(color: colorScheme.outlineVariant)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: Text('Scope: ${filter.targetScope.toUpperCase()}'),
                    selected: filter.targetScope != 'all',
                    onSelected: (_) => _openFilterDialog(),
                  ),
                  if (surahName != null) ...[
                    const SizedBox(width: 8),
                    Chip(
                      label: Text('Surah: $surahName'),
                      onDeleted: () {
                        ref.read(searchFilterStateProvider.notifier).state = filter.copyWith(surahNumber: null);
                      },
                    ),
                  ],
                  if (filter.juz != null) ...[
                    const SizedBox(width: 8),
                    Chip(
                      label: Text('Juz ${filter.juz}'),
                      onDeleted: () {
                        ref.read(searchFilterStateProvider.notifier).state = filter.copyWith(juz: null);
                      },
                    ),
                  ],
                  if (filter.revelationPlace != null) ...[
                    const SizedBox(width: 8),
                    Chip(
                      label: Text('Period: ${filter.revelationPlace!.toUpperCase()}'),
                      onDeleted: () {
                        ref.read(searchFilterStateProvider.notifier).state = filter.copyWith(revelationPlace: null);
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Main Body: Search Results OR History
          Expanded(
            child: query.isEmpty
                ? historyAsync.when(
                    loading: () => Center(child: CircularProgressIndicator(color: colorScheme.primary)),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (historyItems) {
                      final pinned = historyItems.where((i) => i.isPinned).toList();
                      final recent = historyItems.where((i) => !i.isPinned).toList();

                      if (historyItems.isEmpty) {
                        return Center(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(32),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primaryContainer.withValues(alpha: 0.6),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.search, size: 48, color: colorScheme.primary),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Search Free-Text & Concordance',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Search terms across Arabic text or translations. Try exact phrase searches or click popular root queries below.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13),
                                  ),
                                  const SizedBox(height: 24),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      ActionChip(
                                        avatar: Icon(Icons.auto_awesome, size: 16, color: colorScheme.secondary),
                                        label: const Text('Root: ر ح م (Mercy)'),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (ctx) => const RootConcordanceScreen(rootArabic: 'ر ح م'),
                                            ),
                                          );
                                        },
                                      ),
                                      ActionChip(
                                        avatar: Icon(Icons.auto_awesome, size: 16, color: colorScheme.secondary),
                                        label: const Text('Root: ك ت ب (Book)'),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (ctx) => const RootConcordanceScreen(rootArabic: 'ك ت ب'),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                      return ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        children: [
                          if (pinned.isNotEmpty) ...[
                            Text(
                              'Pinned Searches',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: colorScheme.primary),
                            ),
                            const SizedBox(height: 8),
                            ...pinned.map((item) => Card(
                                  margin: const EdgeInsets.only(bottom: 6),
                                  child: ListTile(
                                    leading: Icon(Icons.push_pin, color: colorScheme.primary),
                                    title: Text(item.query, style: const TextStyle(fontWeight: FontWeight.w500)),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.close, size: 18),
                                      onPressed: () {
                                        ref.read(searchHistoryNotifierProvider.notifier).togglePin(item.query);
                                      },
                                    ),
                                    onTap: () {
                                      _searchController.text = item.query;
                                      _onSearchSubmitted(item.query);
                                    },
                                  ),
                                )),
                            const SizedBox(height: 12),
                          ],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recent Searches',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: colorScheme.onSurfaceVariant),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref.read(searchHistoryNotifierProvider.notifier).clearHistory();
                                },
                                child: const Text('Clear All'),
                              ),
                            ],
                          ),
                          ...recent.map((item) => Card(
                                margin: const EdgeInsets.only(bottom: 6),
                                child: ListTile(
                                  leading: Icon(Icons.history, color: colorScheme.onSurfaceVariant),
                                  title: Text(item.query),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.push_pin_outlined, size: 18),
                                    onPressed: () {
                                      ref.read(searchHistoryNotifierProvider.notifier).togglePin(item.query);
                                    },
                                  ),
                                  onTap: () {
                                    _searchController.text = item.query;
                                    _onSearchSubmitted(item.query);
                                  },
                                ),
                              )),
                        ],
                      );
                    },
                  )
                : resultsAsync.when(
                    loading: () => Center(child: CircularProgressIndicator(color: colorScheme.primary)),
                    error: (err, stack) => Center(child: Text('Error executing search: $err')),
                    data: (results) {
                      if (results.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.search_off, size: 48, color: colorScheme.onSurfaceVariant),
                                const SizedBox(height: 12),
                                Text('No results found for "$query"', style: const TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                Text(
                                  'Try adjusting your search query or expanding search filters.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              'Found ${results.length} matching verses',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: colorScheme.primary),
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              itemCount: results.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final result = results[index];
                                return Card(
                                  child: ListTile(
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${result.surahNameTranslit} (${result.surahNumber}:${result.ayahNumber})',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: result.sourceType == 'arabic'
                                                ? colorScheme.primary.withValues(alpha: 0.15)
                                                : colorScheme.secondary.withValues(alpha: 0.15),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            result.sourceType == 'arabic' ? 'Arabic' : 'Translation',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: result.sourceType == 'arabic' ? colorScheme.primary : colorScheme.secondary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: _FormattedSnippet(snippet: result.textSnippet),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (ctx) => const QuranReaderScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _FormattedSnippet extends StatelessWidget {
  final String snippet;

  const _FormattedSnippet({required this.snippet});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final spans = <TextSpan>[];
    final regex = RegExp(r'<b>(.*?)<\/b>');

    int currentIndex = 0;
    for (final match in regex.allMatches(snippet)) {
      if (match.start > currentIndex) {
        spans.add(TextSpan(text: snippet.substring(currentIndex, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          backgroundColor: colorScheme.secondary.withValues(alpha: 0.3),
          color: colorScheme.primary,
        ),
      ));
      currentIndex = match.end;
    }
    if (currentIndex < snippet.length) {
      spans.add(TextSpan(text: snippet.substring(currentIndex)));
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          color: colorScheme.onSurface,
          height: 1.5,
        ),
        children: spans,
      ),
    );
  }
}

class _SearchFilterModal extends ConsumerWidget {
  const _SearchFilterModal();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(searchFilterStateProvider);
    final surahsAsync = ref.watch(surahsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Search Filters & Scope',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                ),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const Divider(),
            const SizedBox(height: 12),

            // Target Scope
            Text('Search Scope', style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary)),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'all', label: Text('All')),
                ButtonSegment(value: 'arabic', label: Text('Arabic')),
                ButtonSegment(value: 'translation', label: Text('Translation')),
              ],
              selected: {filter.targetScope},
              onSelectionChanged: (val) {
                ref.read(searchFilterStateProvider.notifier).state = filter.copyWith(targetScope: val.first);
              },
            ),
            const SizedBox(height: 16),

            // Revelation Period
            Text('Revelation Period', style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary)),
            const SizedBox(height: 8),
            Row(
              children: [
                ChoiceChip(
                  label: const Text('All Periods'),
                  selected: filter.revelationPlace == null,
                  onSelected: (_) => ref.read(searchFilterStateProvider.notifier).state = filter.copyWith(revelationPlace: null),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Meccan'),
                  selected: filter.revelationPlace == 'makkah',
                  onSelected: (_) => ref.read(searchFilterStateProvider.notifier).state = filter.copyWith(revelationPlace: 'makkah'),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Medinan'),
                  selected: filter.revelationPlace == 'madinah',
                  onSelected: (_) => ref.read(searchFilterStateProvider.notifier).state = filter.copyWith(revelationPlace: 'madinah'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Surah Filter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filter by Surah', style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary)),
                if (filter.surahNumber != null)
                  TextButton(
                    onPressed: () => ref.read(searchFilterStateProvider.notifier).state = filter.copyWith(surahNumber: null),
                    child: const Text('Clear'),
                  ),
              ],
            ),
            surahsAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (surahs) {
                return DropdownButton<int?>(
                  isExpanded: true,
                  value: filter.surahNumber,
                  hint: const Text('All 114 Surahs'),
                  items: [
                    const DropdownMenuItem<int?>(value: null, child: Text('All Surahs')),
                    ...surahs.map((s) => DropdownMenuItem<int?>(
                          value: s.number,
                          child: Text('${s.number}. ${s.nameTranslit} (${s.nameArabic})'),
                        )),
                  ],
                  onChanged: (val) {
                    ref.read(searchFilterStateProvider.notifier).state = filter.copyWith(surahNumber: val);
                  },
                );
              },
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
