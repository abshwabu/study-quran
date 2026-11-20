import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/providers.dart';
import '../../../core/database/daos/tafsir_dao.dart';
import '../providers/tafsir_providers.dart';

class TafsirComparisonScreen extends ConsumerStatefulWidget {
  final int surahNumber;
  final int ayahNumber;
  final List<String>? initialSelectedTafsirIds;

  const TafsirComparisonScreen({
    super.key,
    required this.surahNumber,
    required this.ayahNumber,
    this.initialSelectedTafsirIds,
  });

  @override
  ConsumerState<TafsirComparisonScreen> createState() => _TafsirComparisonScreenState();
}

class _TafsirComparisonScreenState extends ConsumerState<TafsirComparisonScreen> {
  late Set<String> _selectedTafsirIds;

  @override
  void initState() {
    super.initState();
    if (widget.initialSelectedTafsirIds != null && widget.initialSelectedTafsirIds!.isNotEmpty) {
      _selectedTafsirIds = Set.from(widget.initialSelectedTafsirIds!);
    } else {
      // Default to comparing ar.muyassar and en.jalalayn
      _selectedTafsirIds = {'ar.muyassar', 'en.jalalayn'};
    }
  }

  void _toggleTafsirSelection(String tafsirId) {
    setState(() {
      if (_selectedTafsirIds.contains(tafsirId)) {
        if (_selectedTafsirIds.length > 1) {
          _selectedTafsirIds.remove(tafsirId);
        }
      } else {
        _selectedTafsirIds.add(tafsirId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final metaListAsync = ref.watch(availableTafsirsMetaProvider);
    final surahsAsync = ref.watch(surahsProvider);
    final ayahsAsync = ref.watch(surahDetailProvider(widget.surahNumber));

    final comparisonAsync = ref.watch(
      comparisonTafsirsProvider((
        tafsirIds: _selectedTafsirIds.toList(),
        surahNumber: widget.surahNumber,
        ayahNumber: widget.ayahNumber,
      )),
    );

    final surahMeta = surahsAsync.value?.firstWhere(
      (s) => s.number == widget.surahNumber,
      orElse: () => surahsAsync.value?.first ?? surahsAsync.value![0],
    );

    final currentAyahData = ayahsAsync.value?.firstWhere(
      (a) => a.ayah.ayahNumber == widget.ayahNumber,
      orElse: () => ayahsAsync.value?.first ?? ayahsAsync.value![0],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Compare Tafsirs (${surahMeta?.nameTranslit ?? "Surah ${widget.surahNumber}"} ${widget.surahNumber}:${widget.ayahNumber})'),
      ),
      body: Column(
        children: [
          // Ayah Arabic Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
              border: Border(bottom: BorderSide(color: colorScheme.outlineVariant)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  currentAyahData?.ayah.arabicTextUthmani ?? '',
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Uthmani',
                    fontSize: 20,
                    height: 1.7,
                    color: colorScheme.onSurface,
                  ),
                ),
                if (currentAyahData?.translationText != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    currentAyahData!.translationText!,
                    style: TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ),

          // Selector Filter Chips
          metaListAsync.when(
            loading: () => const SizedBox(height: 40),
            error: (_, __) => const SizedBox.shrink(),
            data: (metas) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: metas.map((meta) {
                      final isSelected = _selectedTafsirIds.contains(meta.tafsirId);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          selected: isSelected,
                          label: Text(meta.name),
                          selectedColor: colorScheme.primaryContainer,
                          onSelected: (_) => _toggleTafsirSelection(meta.tafsirId),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
          Divider(height: 1, color: colorScheme.outlineVariant),

          // Comparison List / Columns Body
          Expanded(
            child: comparisonAsync.when(
              loading: () => Center(child: CircularProgressIndicator(color: colorScheme.primary)),
              error: (err, stack) => Center(child: Text('Error loading comparison: $err')),
              data: (entries) {
                if (entries.isEmpty) {
                  return Center(
                    child: Text(
                      'No commentary available for selected Tafsirs.',
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                  );
                }

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final isWideScreen = constraints.maxWidth >= 700;

                    if (isWideScreen) {
                      // Side-by-Side Column Layout for Wide Screens
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: entries.map((entry) {
                          return Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainer,
                                border: Border.all(color: colorScheme.outlineVariant),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: _TafsirCard(entry: entry),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      // Stacked Layout for Phone / Narrow Screens
                      return ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: entries.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          return Card(
                            child: _TafsirCard(entry: entryCard(entries[index])),
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  TafsirEntryWithMeta entryCard(TafsirEntryWithMeta entry) => entry;
}

class _TafsirCard extends StatelessWidget {
  final TafsirEntryWithMeta entry;

  const _TafsirCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isRange = entry.content.startAyah != entry.content.endAyah;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  entry.meta.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorScheme.primary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  entry.meta.language.toUpperCase(),
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: colorScheme.onSurfaceVariant),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            'Author: ${entry.meta.author}',
            style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
          ),
          if (isRange) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: colorScheme.secondary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Range Commentary: Ayahs ${entry.content.startAyah}–${entry.content.endAyah}',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: colorScheme.secondary),
              ),
            ),
          ],
          Divider(height: 16, color: colorScheme.outlineVariant),
          Text(
            entry.content.textContent,
            textDirection: entry.meta.language == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            style: TextStyle(
              fontSize: entry.meta.language == 'ar' ? 17 : 14,
              height: 1.6,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
