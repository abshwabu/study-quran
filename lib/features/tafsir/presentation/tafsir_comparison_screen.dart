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
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  currentAyahData?.ayah.arabicTextUthmani ?? '',
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontFamily: 'Uthmani',
                    fontSize: 20,
                    height: 1.7,
                  ),
                ),
                if (currentAyahData?.translationText != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    currentAyahData!.translationText!,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
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
                          selectedColor: Theme.of(context).colorScheme.primaryContainer,
                          onSelected: (_) => _toggleTafsirSelection(meta.tafsirId),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
          const Divider(height: 1),

          // Comparison List / Columns Body
          Expanded(
            child: comparisonAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error loading comparison: $err')),
              data: (entries) {
                if (entries.isEmpty) {
                  return const Center(
                    child: Text('No commentary available for selected Tafsirs.'),
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
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
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
                            elevation: 2,
                            child: _TafsirCard(entry: entries[index]),
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
}

class _TafsirCard extends StatelessWidget {
  final TafsirEntryWithMeta entry;

  const _TafsirCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final isRange = entry.content.startAyah != entry.content.endAyah;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                entry.meta.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal),
              ),
              Chip(
                labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                visualDensity: VisualDensity.compact,
                label: Text(entry.meta.language.toUpperCase(), style: const TextStyle(fontSize: 10)),
              ),
            ],
          ),
          Text(
            'Author: ${entry.meta.author}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          if (isRange) ...[
            const SizedBox(height: 6),
            Chip(
              avatar: const Icon(Icons.linear_scale, size: 14),
              backgroundColor: Colors.amber.shade100,
              labelStyle: const TextStyle(fontSize: 11),
              label: Text('Range Commentary: Ayahs ${entry.content.startAyah}–${entry.content.endAyah}'),
            ),
          ],
          const Divider(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                entry.content.textContent,
                textDirection: entry.meta.language == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                style: TextStyle(
                  fontSize: entry.meta.language == 'ar' ? 17 : 14,
                  height: 1.6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
