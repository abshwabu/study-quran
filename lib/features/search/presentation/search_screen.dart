import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/providers.dart';
import '../../../core/database/daos/search_dao.dart';
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const _SearchFilterModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryStateProvider);
    final filter = ref.watch(searchFilterStateProvider);
    final resultsAsync = ref.watch(searchResultsProvider);
    final historyAsync = ref.watch(searchHistoryNotifierProvider);
    final surahsAsync = ref.watch(surahsProvider);

    final surahName = (filter.surahNumber != null && surahsAsync.value != null)
        ? surahsAsync.value!.firstWhere((s) => s.number == filter.surahNumber).nameTranslit
        : null;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: false,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Search Quran text or translation...',
            border: InputBorder.none,
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
              color: (filter.surahNumber != null || filter.juz != null || filter.revelationPlace != null || filter.targetScope != 'all')
                  ? Colors.teal
                  : null,
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
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
                    loading: () => const Center(child: CircularProgressIndicator()),
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
                                  Icon(Icons.search, size: 64, color: Colors.grey.shade400),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Search Free-Text & Root Concordance',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Search terms across Arabic text or installed translations. Try exact phrase search like "in the name" or root queries.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 20),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      ActionChip(
                                        avatar: const Icon(Icons.auto_awesome, size: 16),
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
                                        avatar: const Icon(Icons.auto_awesome, size: 16),
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
                        padding: const EdgeInsets.all(16),
                        children: [
                          if (pinned.isNotEmpty) ...[
                            const Text(
                              'Pinned Searches',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                            ),
                            const SizedBox(height: 8),
                            ...pinned.map((item) => ListTile(
                                  leading: const Icon(Icons.push_pin, color: Colors.teal),
                                  title: Text(item.query),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      ref.read(searchHistoryNotifierProvider.notifier).togglePin(item.query);
                                    },
                                  ),
                                  onTap: () {
                                    _searchController.text = item.query;
                                    _onSearchSubmitted(item.query);
                                  },
                                )),
                            const Divider(height: 24),
                          ],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Recent Searches',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref.read(searchHistoryNotifierProvider.notifier).clearHistory();
                                },
                                child: const Text('Clear All'),
                              ),
                            ],
                          ),
                          ...recent.map((item) => ListTile(
                                leading: const Icon(Icons.history, color: Colors.grey),
                                title: Text(item.query),
                                trailing: IconButton(
                                  icon: const Icon(Icons.push_pin_outlined),
                                  onPressed: () {
                                    ref.read(searchHistoryNotifierProvider.notifier).togglePin(item.query);
                                  },
                                ),
                                onTap: () {
                                  _searchController.text = item.query;
                                  _onSearchSubmitted(item.query);
                                },
                              )),
                        ],
                      );
                    },
                  )
                : resultsAsync.when(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Center(child: Text('Error executing search: $err')),
                    data: (results) {
                      if (results.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.search_off, size: 48, color: Colors.grey),
                                const SizedBox(height: 12),
                                Text('No results found for "$query"'),
                                const SizedBox(height: 8),
                                const Text(
                                  'Try adjusting your search query or expanding search filters.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey, fontSize: 13),
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
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                                        ),
                                        Chip(
                                          labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                                          visualDensity: VisualDensity.compact,
                                          backgroundColor: result.sourceType == 'arabic' ? Colors.green.shade50 : Colors.blue.shade50,
                                          label: Text(
                                            result.sourceType == 'arabic' ? 'Arabic' : 'Translation',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: result.sourceType == 'arabic' ? Colors.green.shade800 : Colors.blue.shade800,
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
    // Parse HTML <b>...</b> highlighting tags from FTS5 snippet
    final spans = <TextSpan>[];
    final regex = RegExp(r'<b>(.*?)<\/b>');

    int currentIndex = 0;
    for (final match in regex.allMatches(snippet)) {
      if (match.start > currentIndex) {
        spans.add(TextSpan(text: snippet.substring(currentIndex, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          backgroundColor: Color(0xFFFFF59D),
          color: Colors.black,
        ),
      ));
      currentIndex = match.end;
    }
    if (currentIndex < snippet.length) {
      spans.add(TextSpan(text: snippet.substring(currentIndex)));
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
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
                const Text('Search Filters & Scope', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const Divider(),
            const SizedBox(height: 12),

            // Target Scope
            const Text('Search Scope', style: TextStyle(fontWeight: FontWeight.bold)),
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
            const Text('Revelation Period', style: TextStyle(fontWeight: FontWeight.bold)),
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
                const Text('Filter by Surah', style: TextStyle(fontWeight: FontWeight.bold)),
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
